require 'rails_helper'

RSpec.describe "applicable_criteria/show", type: :view do
  before(:each) do
    @applicable_criterium = assign(:applicable_criterium, ApplicableCriterium.create!(
      :criteria => nil,
      :criteria_type => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(//)
  end
end
