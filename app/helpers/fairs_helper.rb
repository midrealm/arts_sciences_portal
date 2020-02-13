module FairsHelper
  def scoresheets_visible?(fair, user)
    return true if fair.scoresheets_allowed
    entries = fair.entries.judge_assigned_entries(current_user).joins(:category).pluck(:'categories.mail_in')
    entries.include?(true) && fair.mail_in_scoresheets_allowed
  end

  def next_fair
    Fair.current.order(date: :asc).first
  end
end
