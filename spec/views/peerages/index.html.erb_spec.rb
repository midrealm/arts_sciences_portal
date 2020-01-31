require 'rails_helper'

RSpec.describe "peerages/index", type: :view do
  before(:each) do
    assign(:peerages, [
      Peerage.create!(
        :description => "Description"
      ),
      Peerage.create!(
        :description => "Description"
      )
    ])
  end

  it "renders a list of peerages" do
    render
    assert_select "tr>td", :text => "Description".to_s, :count => 2
  end
end
