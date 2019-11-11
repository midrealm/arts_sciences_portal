require 'rails_helper'

RSpec.describe "scoresheets/edit", type: :view do
  before(:each) do
    @scoresheet = assign(:scoresheet, Scoresheet.create!(
      :score => nil,
      :user => nil,
      :entry => nil
    ))
  end

  it "renders the edit scoresheet form" do
    render

    assert_select "form[action=?][method=?]", scoresheet_path(@scoresheet), "post" do

      assert_select "input[name=?]", "scoresheet[score_id]"

      assert_select "input[name=?]", "scoresheet[user_id]"

      assert_select "input[name=?]", "scoresheet[entry_id]"
    end
  end
end
