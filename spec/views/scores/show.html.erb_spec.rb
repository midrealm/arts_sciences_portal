require 'rails_helper'

RSpec.describe "scores/show", type: :view do
  before(:each) do
    @score = assign(:score, Score.create!(
      :criteria => nil,
      :comment => "MyText",
      :score => 2
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/2/)
  end
end
