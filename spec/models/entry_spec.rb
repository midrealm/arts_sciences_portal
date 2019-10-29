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

  describe '.timeslot_description' do
    context 'when timeslot is unassigned' do
      let(:entry) {FactoryBoty.create(:entry, :unassigned)}
      it 'returns unassigned' do
        expect(entry.timeslot_description).to eq('Unassigned')
      end
    end

    context 'when timeslot is assigned' do
      let(:entry) {FactoryBoty.create(:entry)}
      it 'returns the timeslot' do
        expect(entry.timeslot_description).to eq('Unassigned')
      end
    end
  end

  describe '.scored_option' do
    context 'when entry is scored' do
      let(:entry) {FactoryBoty.create(:entry, scored: true)}
      it 'returns scored' do
        expect(entry.scored_option).to eq('Scored')
      end
    end

    context 'when entry is not scored' do
      let(:entry) {FactoryBoty.create(:entry, scored: false)}
      it 'returns commentary only' do
        expect(entry.scored_option).to eq('Commentary Only')
      end
    end
  end

  describe '.in_person_option' do
    context 'when entry is in person' do
      let(:entry) {FactoryBoty.create(:entry, in_person: true)}
      it 'returns face to face' do
        expect(entry.in_person_option).to eq('Face-to-face')
      end
    end

    context 'when entry is not in person' do
      let(:entry) {FactoryBoty.create(:entry, in_person: false)}
      it 'returns not face to face' do
        expect(entry.in_person_option).to eq('Not Face-to-face')
      end
    end
  end
end
