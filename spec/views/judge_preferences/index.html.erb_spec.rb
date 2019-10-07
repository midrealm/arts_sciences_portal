require 'rails_helper'

RSpec.describe "judge_preferences/index", type: :view do
  before(:each) do
    assign(:judge_preferences, [
      JudgePreference.create!(),
      JudgePreference.create!()
    ])
  end

  it "renders a list of judge_preferences" do
    render
  end
end
