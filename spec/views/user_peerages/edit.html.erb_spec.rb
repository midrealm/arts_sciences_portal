require 'rails_helper'

RSpec.describe "user_peerages/edit", type: :view do
  before(:each) do
    @user_peerage = assign(:user_peerage, UserPeerage.create!(
      :user => nil,
      :peerage => nil
    ))
  end

  it "renders the edit user_peerage form" do
    render

    assert_select "form[action=?][method=?]", user_peerage_path(@user_peerage), "post" do

      assert_select "input[name=?]", "user_peerage[user_id]"

      assert_select "input[name=?]", "user_peerage[peerage_id]"
    end
  end
end
