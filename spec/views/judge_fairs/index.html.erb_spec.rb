require 'rails_helper'

RSpec.describe "judge_fairs/index", type: :view do
  before(:each) do
    assign(:judge_fairs, [
      JudgeFair.create!(
        :user => nil,
        :fair => nil
      ),
      JudgeFair.create!(
        :user => nil,
        :fair => nil
      )
    ])
  end

  it "renders a list of judge_fairs" do
    render
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
