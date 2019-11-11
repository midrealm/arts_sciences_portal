require 'rails_helper'

RSpec.describe "scoresheets/show", type: :view do
  before(:each) do
    @scoresheet = assign(:scoresheet, Scoresheet.create!(
      :score => nil,
      :user => nil,
      :entry => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
  end
end
