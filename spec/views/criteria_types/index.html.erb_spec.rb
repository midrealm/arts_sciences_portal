require 'rails_helper'

RSpec.describe "criteria_types/index", type: :view do
  before(:each) do
    assign(:criteria_types, [
      CriteriaType.create!(
        :string => ""
      ),
      CriteriaType.create!(
        :string => ""
      )
    ])
  end

  it "renders a list of criteria_types" do
    render
    assert_select "tr>td", :text => "".to_s, :count => 2
  end
end
