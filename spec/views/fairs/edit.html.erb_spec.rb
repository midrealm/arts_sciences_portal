require 'rails_helper'

RSpec.describe "fairs/edit", type: :view do
  before(:each) do
    @fair = assign(:fair, Fair.create!(
      :region => 1
    ))
  end

  it "renders the edit fair form" do
    render

    assert_select "form[action=?][method=?]", fair_path(@fair), "post" do

      assert_select "input[name=?]", "fair[region]"
    end
  end
end
