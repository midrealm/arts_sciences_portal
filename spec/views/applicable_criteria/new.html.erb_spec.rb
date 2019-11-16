require 'rails_helper'

RSpec.describe "applicable_criteria/new", type: :view do
  before(:each) do
    assign(:applicable_criterium, ApplicableCriterium.new(
      :criteria => nil,
      :criteria_type => nil
    ))
  end

  it "renders new applicable_criterium form" do
    render

    assert_select "form[action=?][method=?]", applicable_criteria_path, "post" do

      assert_select "input[name=?]", "applicable_criterium[criteria_id]"

      assert_select "input[name=?]", "applicable_criterium[criteria_type_id]"
    end
  end
end
