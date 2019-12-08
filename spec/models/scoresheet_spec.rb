require 'rails_helper'

RSpec.describe Scoresheet, type: :model do
  describe ".for_user" do
    let!(:current_user) {FactoryBot.create(:user)}
    let!(:scoresheet_correct) {FactoryBot.create(:scoresheet, user: current_user)}
    let!(:scoresheet_incorrect) {FactoryBot.create(:scoresheet)}

    it "returns only scoresheets for current user" do
      scoresheets = Scoresheet.for_user(current_user).pluck(:id)
      expect(scoresheets).to include scoresheet_correct.id
      expect(scoresheets).to_not include scoresheet_incorrect.id
    end
  end
end
