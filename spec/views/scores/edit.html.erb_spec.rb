require 'rails_helper'

RSpec.describe "scores/edit", type: :view do
  before(:each) do
    @score = assign(:score, Score.create!(
      :criteria => nil,
      :comment => "MyText",
      :score => 1
    ))
  end

  it "renders the edit score form" do
    render

    assert_select "form[action=?][method=?]", score_path(@score), "post" do

      assert_select "input[name=?]", "score[criteria_id]"

      assert_select "textarea[name=?]", "score[comment]"

      assert_select "input[name=?]", "score[score]"
    end
  end
end
