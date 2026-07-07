module FairsHelper
  def scoresheets_visible?(fair, current_user)
    return true if fair.scoresheets_allowed
    entries = fair.entries.judge_assigned_entries(current_user).joins(:division).where('divisions.name = ?', 'Research')
    !entries.empty? && fair.mail_in_scoresheets_allowed
  end

  def next_fair
    Fair.current.order(date: :asc).first
  end

  def next_kingdom_fair
    Fair.current.kingdom.order(date: :asc).first
  end

  # Within one timeslot (schedule section), location IDs assigned to more than one entry (room conflict).
  def view_schedule_duplicate_room_ids(slot_entries)
    counts = Hash.new(0)
    slot_entries.each do |e|
      next if e.location_id.blank?

      counts[e.location_id] += 1
    end
    counts.select { |_id, n| n > 1 }.keys
  end

  # Entry IDs where that entry shares at least one judge with another entry in the same timeslot.
  def view_schedule_double_booked_judge_entry_ids(slot_entries)
    by_user = Hash.new { |h, k| h[k] = [] }
    slot_entries.each do |entry|
      entry.judge_assigns.each do |ja|
        by_user[ja.user_id] << entry.id
      end
    end
    conflict_ids = []
    by_user.each_value do |entry_ids|
      uniq_ids = entry_ids.uniq
      next if uniq_ids.size < 2

      conflict_ids.concat(uniq_ids)
    end
    conflict_ids.uniq
  end

  def view_schedule_conflict_row_class(entry, duplicate_room_ids, judge_conflict_entry_ids)
    room_dup =
      entry.location_id.present? &&
      duplicate_room_ids.include?(entry.location_id)
    judge_dup = judge_conflict_entry_ids.include?(entry.id)

    (room_dup || judge_dup) ? "table-danger" : ""
  end

  def judge_preferences_popover_body(user)
    prefs = user.judge_preferences.sort_by { |jp| jp.preference.name }

    if prefs.empty?
      return content_tag(:p, "No judging preferences set.", class: "small mb-0")
    end

    content_tag(:ul, class: "small mb-0 ps-3") do
      safe_join(prefs.map { |jp| content_tag(:li, jp.preference.name) })
    end
  end

  def schedule_timeslot_id(entry, proposed_schedule, preview)
    if preview && proposed_schedule[entry.id]
      proposed_schedule[entry.id][:timeslot_id]
    else
      entry.timeslot_id
    end
  end

  def schedule_location_id(entry, proposed_schedule, preview)
    if preview && proposed_schedule[entry.id]
      proposed_schedule[entry.id][:location_id]
    else
      entry.location_id
    end
  end

  def schedule_judge_assigned?(entry, user, proposed_schedule, preview)
    if preview && proposed_schedule[entry.id]
      proposed_schedule[entry.id][:judge_ids].include?(user.id)
    else
      user.judging_entry?(entry)
    end
  end

  def schedule_unassigned_entries(entries, proposed_schedule, preview)
    return [] unless preview

    entries.reject { |entry| proposed_schedule.key?(entry.id) }
  end

  def schedule_needs_manual_assignment?(entry, proposed_schedule, preview)
    preview && !proposed_schedule.key?(entry.id)
  end

  def order_by_preference(collection, entry)
    entry_preference_ids = entry.preferences.map(&:id).to_set

    collection.sort_by do |user|
      overlap = user.judge_preferences.count { |jp| entry_preference_ids.include?(jp.preference_id) }
      [-overlap, user.email_or_name]
    end
  end
end
