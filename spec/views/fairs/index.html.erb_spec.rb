require 'rails_helper'

RSpec.describe "fairs/index", type: :view do
  before(:each) do
    assign(:fairs, [
      Fair.create!(
        :region => 2
      ),
      Fair.create!(
        :region => 2
      )
    ])
  end

  it "renders a list of fairs" do
    render
    assert_select "tr>td", :text => 2.to_s, :count => 2
  end
end
