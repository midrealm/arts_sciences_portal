require 'rails_helper'

RSpec.describe "criteria_descriptions/show", type: :view do
  before(:each) do
    @criteria_description = assign(:criteria_description, CriteriaDescription.create!(
      :description => "MyText",
      :category => nil,
      :criteria_type => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
  end
end
