require 'rails_helper'

RSpec.describe "criteria/edit", type: :view do
  before(:each) do
    @criterium = assign(:criterium, Criterium.create!(
      :description => "MyString",
      :criteria_type => nil,
      :division => nil,
      :category => nil,
      :score_range => 1,
      :optional => false,
      :animal => false
    ))
  end

  it "renders the edit criterium form" do
    render

    assert_select "form[action=?][method=?]", criterium_path(@criterium), "post" do

      assert_select "input[name=?]", "criterium[description]"

      assert_select "input[name=?]", "criterium[criteria_type_id]"

      assert_select "input[name=?]", "criterium[division_id]"

      assert_select "input[name=?]", "criterium[category_id]"

      assert_select "input[name=?]", "criterium[score_range]"

      assert_select "input[name=?]", "criterium[optional]"

      assert_select "input[name=?]", "criterium[animal]"
    end
  end
end
