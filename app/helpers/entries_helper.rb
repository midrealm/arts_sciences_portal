module EntriesHelper
  SCORE_DIVERGENCE = 10

  def pent_score_for(user, fair)
    pents = Entry.pentathlons(fair).user_entries(user)
    sum = 0

    pents.each do |pent|
      sum += pent.final_score
    end

    (sum / pents.count).round(2)
  end

  def div_score_for(user, fair)
    divs = Entry.division_types(fair).user_entries(user).sort {|a,b| b.final_score <=> a.final_score}
    top_three = divs.slice(0, 3)
    sum = 0

    top_three.each do |div|
      sum += div.final_score
    end

    (sum / 3).round(2)
  end

  def needs_review?(entry)
    return false if entry.scoresheets.empty?

    scores = entry.scoresheets.sort {|a,b| b.total_score <=> a.total_score}
    top_score = scores.first.total_score
    bottom_score = scores.last.total_score
    top_score - bottom_score > SCORE_DIVERGENCE
  end
end
