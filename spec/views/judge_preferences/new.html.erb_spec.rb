require 'rails_helper'

RSpec.describe "judge_preferences/new", type: :view do
  before(:each) do
    assign(:judge_preference, JudgePreference.new())
  end

  it "renders new judge_preference form" do
    render

    assert_select "form[action=?][method=?]", judge_preferences_path, "post" do
    end
  end
end
