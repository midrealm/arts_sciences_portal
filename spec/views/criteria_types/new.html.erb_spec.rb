require 'rails_helper'

RSpec.describe "criteria_types/new", type: :view do
  before(:each) do
    assign(:criteria_type, CriteriaType.new(
      :string => ""
    ))
  end

  it "renders new criteria_type form" do
    render

    assert_select "form[action=?][method=?]", criteria_types_path, "post" do

      assert_select "input[name=?]", "criteria_type[string]"
    end
  end
end
