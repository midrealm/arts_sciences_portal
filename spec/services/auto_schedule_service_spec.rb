require "rails_helper"

RSpec.describe AutoScheduleService do
  describe "#call" do
    let(:fair) { FactoryBot.create(:fair) }
    let!(:timeslot1) { FactoryBot.create(:timeslot, order: 1, description: "Morning") }
    let!(:timeslot2) { FactoryBot.create(:timeslot, order: 2, description: "Afternoon") }
    let!(:room1) { FactoryBot.create(:location, fair: fair, description: "Room A") }
    let!(:room2) { FactoryBot.create(:location, fair: fair, description: "Room B") }
    let!(:weaving) { FactoryBot.create(:preference, name: "Weaving") }
    let!(:cooking) { FactoryBot.create(:preference, name: "Cooking") }

    let!(:judge1) { FactoryBot.create(:user) }
    let!(:judge2) { FactoryBot.create(:user) }
    let!(:judge3) { FactoryBot.create(:user) }

    let!(:entry1) { FactoryBot.create(:entry, fair: fair, entry_name: "Entry 1", timeslot: nil, location: nil) }
    let!(:entry2) { FactoryBot.create(:entry, fair: fair, entry_name: "Entry 2", timeslot: nil, location: nil) }

    before do
      [judge1, judge2, judge3].each do |judge|
        FactoryBot.create(:judge_fair, user: judge, fair: fair)
      end

      FactoryBot.create(:judge_preference, user: judge1, preference: weaving)
      FactoryBot.create(:judge_preference, user: judge2, preference: weaving)
      FactoryBot.create(:judge_preference, user: judge3, preference: cooking)

      entry1.preferences << weaving
      entry2.preferences << cooking
    end

    subject(:proposal) do
      described_class.new(
        entries: Entry.where(id: [entry1.id, entry2.id]).includes(:preferences),
        judges: User.where(id: [judge1.id, judge2.id, judge3.id]).includes(judge_preferences: :preference),
        timeslots: Timeslot.all.in_order,
        locations: Location.for_fair(fair)
      ).call
    end

    it "assigns each entry a timeslot and room" do
      expect(proposal[entry1.id][:timeslot_id]).to be_present
      expect(proposal[entry1.id][:location_id]).to be_present
      expect(proposal[entry2.id][:timeslot_id]).to be_present
      expect(proposal[entry2.id][:location_id]).to be_present
    end

    it "assigns at most MAX_JUDGES_PER_ENTRY judges per entry" do
      proposal.each_value do |placement|
        expect(placement[:judge_ids].size).to be <= AutoScheduleService::MAX_JUDGES_PER_ENTRY
      end
    end

    it "does not double-book judges within a timeslot" do
      by_timeslot = Hash.new { |h, k| h[k] = [] }

      proposal.each_value do |placement|
        placement[:judge_ids].each do |judge_id|
          by_timeslot[placement[:timeslot_id]] << judge_id
        end
      end

      by_timeslot.each_value do |judge_ids|
        expect(judge_ids.uniq.size).to eq(judge_ids.size)
      end
    end

    it "does not double-book rooms within a timeslot" do
      by_timeslot = Hash.new { |h, k| h[k] = [] }

      proposal.each_value do |placement|
        by_timeslot[placement[:timeslot_id]] << placement[:location_id]
      end

      by_timeslot.each_value do |room_ids|
        expect(room_ids.uniq.size).to eq(room_ids.size)
      end
    end

    it "prefers judges whose preferences match the entry" do
      expect(proposal[entry1.id][:judge_ids]).to include(judge1.id, judge2.id)
      expect(proposal[entry2.id][:judge_ids]).to include(judge3.id)
    end
  end
end
