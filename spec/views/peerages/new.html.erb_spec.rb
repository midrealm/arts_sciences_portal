require 'rails_helper'

RSpec.describe "peerages/new", type: :view do
  before(:each) do
    assign(:peerage, Peerage.new(
      :description => "MyString"
    ))
  end

  it "renders new peerage form" do
    render

    assert_select "form[action=?][method=?]", peerages_path, "post" do

      assert_select "input[name=?]", "peerage[description]"
    end
  end
end
