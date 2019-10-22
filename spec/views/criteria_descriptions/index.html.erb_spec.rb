require 'rails_helper'

RSpec.describe "criteria_descriptions/index", type: :view do
  before(:each) do
    assign(:criteria_descriptions, [
      CriteriaDescription.create!(
        :description => "MyText",
        :category => nil,
        :criteria_type => nil
      ),
      CriteriaDescription.create!(
        :description => "MyText",
        :category => nil,
        :criteria_type => nil
      )
    ])
  end

  it "renders a list of criteria_descriptions" do
    render
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
