require 'rails_helper'

RSpec.describe "user_peerages/show", type: :view do
  before(:each) do
    @user_peerage = assign(:user_peerage, UserPeerage.create!(
      :user => nil,
      :peerage => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(//)
  end
end
