require 'rails_helper'

RSpec.describe "criteria_types/edit", type: :view do
  before(:each) do
    @criteria_type = assign(:criteria_type, CriteriaType.create!(
      :string => ""
    ))
  end

  it "renders the edit criteria_type form" do
    render

    assert_select "form[action=?][method=?]", criteria_type_path(@criteria_type), "post" do

      assert_select "input[name=?]", "criteria_type[string]"
    end
  end
end
