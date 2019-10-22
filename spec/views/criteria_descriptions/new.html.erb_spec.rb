require 'rails_helper'

RSpec.describe "criteria_descriptions/new", type: :view do
  before(:each) do
    assign(:criteria_description, CriteriaDescription.new(
      :description => "MyText",
      :category => nil,
      :criteria_type => nil
    ))
  end

  it "renders new criteria_description form" do
    render

    assert_select "form[action=?][method=?]", criteria_descriptions_path, "post" do

      assert_select "textarea[name=?]", "criteria_description[description]"

      assert_select "input[name=?]", "criteria_description[category_id]"

      assert_select "input[name=?]", "criteria_description[criteria_type_id]"
    end
  end
end
