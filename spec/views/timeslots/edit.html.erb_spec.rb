require 'rails_helper'

RSpec.describe "timeslots/edit", type: :view do
  before(:each) do
    @timeslot = assign(:timeslot, Timeslot.create!(
      :order => 1,
      :description => "MyString"
    ))
  end

  it "renders the edit timeslot form" do
    render

    assert_select "form[action=?][method=?]", timeslot_path(@timeslot), "post" do

      assert_select "input[name=?]", "timeslot[order]"

      assert_select "input[name=?]", "timeslot[description]"
    end
  end
end
