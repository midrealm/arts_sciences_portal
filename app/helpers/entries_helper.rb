module EntriesHelper
  def pent_score_for(user, fair)
    pents = Entry.pentathlons(fair).user_entries(user)
    sum = 0

    pents.each do |pent|
      sum += pent.final_score
    end

    (sum / pents.count).round(2)
  end

  def div_score_for(user, fair)
    divs = Entry.divisions(fair).user_entries(user).sort {|a,b| b.final_score <=> a.final_score}
    top_three = divs.slice(0, 3)
    sum = 0

    top_three.each do |div|
      sum += div.final_score
    end

    (sum / 3).round(2)
  end
end
