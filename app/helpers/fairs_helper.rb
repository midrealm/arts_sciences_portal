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

  def order_by_preference(collection, entry)
    collection.sort do |a, b|
      if a.judge_preferences.empty?
        1
      elsif b.judge_preferences.empty?
        0
      elsif a.judge_preferences.where(division_id: entry.division_id).empty?
        1
      else
        0
      end
    end
  end
end
