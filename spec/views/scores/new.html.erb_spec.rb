require 'rails_helper'

RSpec.describe "scores/new", type: :view do
  before(:each) do
    assign(:score, Score.new(
      :criteria => nil,
      :comment => "MyText",
      :score => 1
    ))
  end

  it "renders new score form" do
    render

    assert_select "form[action=?][method=?]", scores_path, "post" do

      assert_select "input[name=?]", "score[criteria_id]"

      assert_select "textarea[name=?]", "score[comment]"

      assert_select "input[name=?]", "score[score]"
    end
  end
end
