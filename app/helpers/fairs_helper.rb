module FairsHelper
  def scoresheets_visible?(fair, user)
    return true if fair.scoresheets_allowed
    entries = fair.entries.judge_assigned_entries(current_user).joins(:category).pluck(:'categories.mail_in')
    entries.include?(true) && fair.mail_in_scoresheets_allowed
  end

  def next_fair
    Fair.current.order(date: :asc).first
  end

  def color_class(entry, relevant_preferences, judge)
    return "blue" unless relevant_preferences.where(user_id: judge.id, category_id: entry.category_id).empty?
    "black"
  end

  def display_peerages(relevant_peerages, judge)
    peerage_string = relevant_peerages.where(user_id: judge.id).map do |peerage|
      peerage.peerage.description[0]
    end.join(" ")
    peerage_string.blank? ? "" : "(#{peerage_string})"
  end

  def judging_entry?(entry, judge, relevant_assignments)
    !relevant_assignments.find_by(entry_id: entry.id, user_id: judge.id).nil?
  end

  def order_by_preference(collection, entry)
    collection.sort do |a, b|
      if a.judge_preferences.empty?
        1
      elsif b.judge_preferences.empty?
        0
      elsif a.judge_preferences.where(category_id: entry.category_id).empty?
        1
      else
        0
      end
    end
  end
end
