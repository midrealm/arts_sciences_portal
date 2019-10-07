require 'rails_helper'

RSpec.describe "judge_preferences/edit", type: :view do
  before(:each) do
    @judge_preference = assign(:judge_preference, JudgePreference.create!())
  end

  it "renders the edit judge_preference form" do
    render

    assert_select "form[action=?][method=?]", judge_preference_path(@judge_preference), "post" do
    end
  end
end
