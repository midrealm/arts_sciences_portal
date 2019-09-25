require 'rails_helper'

RSpec.describe "divisions/show", type: :view do
  before(:each) do
    @division = assign(:division, Division.create!(
      :name => "Name"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
  end
end
