require 'rails_helper'

RSpec.describe Entry, type: :model do
  describe ".user_entries" do
    let!(:current_user) {FactoryBot.create(:user)}
    let!(:entry_correct) {FactoryBot.create(:entry, entry_name: 'entry 1', user: current_user)}
    let!(:entry_incorrect) {FactoryBot.create(:entry, entry_name: 'entry 2')}

    it "returns only entries for current user" do
      entries = Entry.user_entries(current_user).pluck(:entry_name)
      expect(entries).to include 'entry 1'
      expect(entries).to_not include 'entry 2'
    end
  end
end
