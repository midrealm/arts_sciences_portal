require 'rails_helper'

RSpec.describe "timeslots/new", type: :view do
  before(:each) do
    assign(:timeslot, Timeslot.new(
      :order => 1,
      :description => "MyString"
    ))
  end

  it "renders new timeslot form" do
    render

    assert_select "form[action=?][method=?]", timeslots_path, "post" do

      assert_select "input[name=?]", "timeslot[order]"

      assert_select "input[name=?]", "timeslot[description]"
    end
  end
end
