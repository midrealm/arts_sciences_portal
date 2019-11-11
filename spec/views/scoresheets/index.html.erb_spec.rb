require 'rails_helper'

RSpec.describe "scoresheets/index", type: :view do
  before(:each) do
    assign(:scoresheets, [
      Scoresheet.create!(
        :score => nil,
        :user => nil,
        :entry => nil
      ),
      Scoresheet.create!(
        :score => nil,
        :user => nil,
        :entry => nil
      )
    ])
  end

  it "renders a list of scoresheets" do
    render
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
