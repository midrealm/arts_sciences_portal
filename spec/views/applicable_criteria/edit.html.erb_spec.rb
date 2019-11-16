require 'rails_helper'

RSpec.describe "applicable_criteria/edit", type: :view do
  before(:each) do
    @applicable_criterium = assign(:applicable_criterium, ApplicableCriterium.create!(
      :criteria => nil,
      :criteria_type => nil
    ))
  end

  it "renders the edit applicable_criterium form" do
    render

    assert_select "form[action=?][method=?]", applicable_criterium_path(@applicable_criterium), "post" do

      assert_select "input[name=?]", "applicable_criterium[criteria_id]"

      assert_select "input[name=?]", "applicable_criterium[criteria_type_id]"
    end
  end
end
