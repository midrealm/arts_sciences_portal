class AutoScheduleService
  MAX_JUDGES_PER_ENTRY = 1

  def initialize(entries:, judges:, timeslots:, locations:)
    @entries = entries
    @judges = judges
    @timeslots = timeslots
    @locations = locations
  end

  def call
    proposal = {}
    judge_busy = Hash.new { |h, k| h[k] = Set.new }
    room_busy = Hash.new { |h, k| h[k] = Set.new }
    judge_preference_ids = judge_preference_map

    sorted_entries(judge_preference_ids).each do |entry|
      entry_preference_ids = entry.preferences.map(&:id).to_set
      placement = find_best_placement(entry_preference_ids, judge_preference_ids, judge_busy, room_busy)

      next unless placement

      proposal[entry.id] = placement
      placement[:judge_ids].each { |judge_id| judge_busy[judge_id] << placement[:timeslot_id] }
      room_busy[placement[:location_id]] << placement[:timeslot_id]
    end

    proposal
  end

  private

  def judge_preference_map
    @judges.each_with_object({}) do |judge, map|
      map[judge.id] = judge.judge_preferences.map(&:preference_id).to_set
    end
  end

  def sorted_entries(judge_preference_ids)
    @entries.sort_by do |entry|
      entry_preference_ids = entry.preferences.map(&:id).to_set
      compatible_judges = @judges.count do |judge|
        (judge_preference_ids[judge.id] & entry_preference_ids).any?
      end

      [-entry_preference_ids.size, compatible_judges, entry.entry_name]
    end
  end

  def find_best_placement(entry_preference_ids, judge_preference_ids, judge_busy, room_busy)
    best = nil
    best_score = -1

    @timeslots.each do |timeslot|
      @locations.each do |location|
        next if room_busy[location.id].include?(timeslot.id)

        available_judges = @judges.reject { |judge| judge_busy[judge.id].include?(timeslot.id) }
        ranked_judges = available_judges.sort_by do |judge|
          overlap = (judge_preference_ids[judge.id] & entry_preference_ids).size
          [-overlap, judge.email_or_name]
        end

        selected_judges = ranked_judges.first(MAX_JUDGES_PER_ENTRY)
        next if selected_judges.empty?

        match_score = selected_judges.sum { |judge| (judge_preference_ids[judge.id] & entry_preference_ids).size }
        score = (match_score * 1000) + selected_judges.size

        next unless score > best_score

        best_score = score
        best = {
          timeslot_id: timeslot.id,
          location_id: location.id,
          judge_ids: selected_judges.map(&:id)
        }
      end
    end

    best
  end
end
