require 'rails_helper'

RSpec.describe "user_peerages/new", type: :view do
  before(:each) do
    assign(:user_peerage, UserPeerage.new(
      :user => nil,
      :peerage => nil
    ))
  end

  it "renders new user_peerage form" do
    render

    assert_select "form[action=?][method=?]", user_peerages_path, "post" do

      assert_select "input[name=?]", "user_peerage[user_id]"

      assert_select "input[name=?]", "user_peerage[peerage_id]"
    end
  end
end
