require 'rails_helper'

RSpec.describe "criteria_descriptions/edit", type: :view do
  before(:each) do
    @criteria_description = assign(:criteria_description, CriteriaDescription.create!(
      :description => "MyText",
      :category => nil,
      :criteria_type => nil
    ))
  end

  it "renders the edit criteria_description form" do
    render

    assert_select "form[action=?][method=?]", criteria_description_path(@criteria_description), "post" do

      assert_select "textarea[name=?]", "criteria_description[description]"

      assert_select "input[name=?]", "criteria_description[category_id]"

      assert_select "input[name=?]", "criteria_description[criteria_type_id]"
    end
  end
end
