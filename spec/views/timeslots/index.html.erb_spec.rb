require 'rails_helper'

RSpec.describe "timeslots/index", type: :view do
  before(:each) do
    assign(:timeslots, [
      Timeslot.create!(
        :order => 2,
        :description => "Description"
      ),
      Timeslot.create!(
        :order => 2,
        :description => "Description"
      )
    ])
  end

  it "renders a list of timeslots" do
    render
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => "Description".to_s, :count => 2
  end
end
