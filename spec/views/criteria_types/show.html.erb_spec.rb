require 'rails_helper'

RSpec.describe "criteria_types/show", type: :view do
  before(:each) do
    @criteria_type = assign(:criteria_type, CriteriaType.create!(
      :string => ""
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
  end
end
