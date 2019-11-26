require 'rails_helper'

RSpec.describe "judge_fairs/edit", type: :view do
  before(:each) do
    @judge_fair = assign(:judge_fair, JudgeFair.create!(
      :user => nil,
      :fair => nil
    ))
  end

  it "renders the edit judge_fair form" do
    render

    assert_select "form[action=?][method=?]", judge_fair_path(@judge_fair), "post" do

      assert_select "input[name=?]", "judge_fair[user_id]"

      assert_select "input[name=?]", "judge_fair[fair_id]"
    end
  end
end
