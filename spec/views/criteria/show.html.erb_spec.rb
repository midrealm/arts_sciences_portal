require 'rails_helper'

RSpec.describe "criteria/show", type: :view do
  before(:each) do
    @criterium = assign(:criterium, Criterium.create!(
      :description => "Description",
      :criteria_type => nil,
      :division => nil,
      :category => nil,
      :score_range => 2,
      :optional => false,
      :animal => false
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Description/)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(/2/)
    expect(rendered).to match(/false/)
    expect(rendered).to match(/false/)
  end
end
