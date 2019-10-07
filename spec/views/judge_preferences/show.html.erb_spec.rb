require 'rails_helper'

RSpec.describe "judge_preferences/show", type: :view do
  before(:each) do
    @judge_preference = assign(:judge_preference, JudgePreference.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
