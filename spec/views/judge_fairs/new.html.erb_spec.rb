require 'rails_helper'

RSpec.describe "judge_fairs/new", type: :view do
  before(:each) do
    assign(:judge_fair, JudgeFair.new(
      :user => nil,
      :fair => nil
    ))
  end

  it "renders new judge_fair form" do
    render

    assert_select "form[action=?][method=?]", judge_fairs_path, "post" do

      assert_select "input[name=?]", "judge_fair[user_id]"

      assert_select "input[name=?]", "judge_fair[fair_id]"
    end
  end
end
