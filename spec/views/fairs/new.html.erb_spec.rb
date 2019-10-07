require 'rails_helper'

RSpec.describe "fairs/new", type: :view do
  before(:each) do
    assign(:fair, Fair.new(
      :region => 1
    ))
  end

  it "renders new fair form" do
    render

    assert_select "form[action=?][method=?]", fairs_path, "post" do

      assert_select "input[name=?]", "fair[region]"
    end
  end
end
