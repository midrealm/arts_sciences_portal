require 'rails_helper'

RSpec.describe "peerages/edit", type: :view do
  before(:each) do
    @peerage = assign(:peerage, Peerage.create!(
      :description => "MyString"
    ))
  end

  it "renders the edit peerage form" do
    render

    assert_select "form[action=?][method=?]", peerage_path(@peerage), "post" do

      assert_select "input[name=?]", "peerage[description]"
    end
  end
end
