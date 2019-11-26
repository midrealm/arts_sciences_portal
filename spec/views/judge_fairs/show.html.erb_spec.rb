require 'rails_helper'

RSpec.describe "judge_fairs/show", type: :view do
  before(:each) do
    @judge_fair = assign(:judge_fair, JudgeFair.create!(
      :user => nil,
      :fair => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(//)
  end
end
