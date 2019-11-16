require 'rails_helper'

RSpec.describe "applicable_criteria/index", type: :view do
  before(:each) do
    assign(:applicable_criteria, [
      ApplicableCriterium.create!(
        :criteria => nil,
        :criteria_type => nil
      ),
      ApplicableCriterium.create!(
        :criteria => nil,
        :criteria_type => nil
      )
    ])
  end

  it "renders a list of applicable_criteria" do
    render
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
