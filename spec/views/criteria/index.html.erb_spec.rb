require 'rails_helper'

RSpec.describe "criteria/index", type: :view do
  before(:each) do
    assign(:criteria, [
      Criterium.create!(
        :description => "Description",
        :criteria_type => nil,
        :division => nil,
        :category => nil,
        :score_range => 2,
        :optional => false,
        :animal => false
      ),
      Criterium.create!(
        :description => "Description",
        :criteria_type => nil,
        :division => nil,
        :category => nil,
        :score_range => 2,
        :optional => false,
        :animal => false
      )
    ])
  end

  it "renders a list of criteria" do
    render
    assert_select "tr>td", :text => "Description".to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
  end
end
