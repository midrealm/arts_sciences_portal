require 'rails_helper'

RSpec.describe "scoresheets/new", type: :view do
  before(:each) do
    assign(:scoresheet, Scoresheet.new(
      :score => nil,
      :user => nil,
      :entry => nil
    ))
  end

  it "renders new scoresheet form" do
    render

    assert_select "form[action=?][method=?]", scoresheets_path, "post" do

      assert_select "input[name=?]", "scoresheet[score_id]"

      assert_select "input[name=?]", "scoresheet[user_id]"

      assert_select "input[name=?]", "scoresheet[entry_id]"
    end
  end
end
