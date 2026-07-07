require "rails_helper"

RSpec.describe Preference, type: :model do
  it "orders by name" do
    preference_b = FactoryBot.create(:preference, name: "B")
    preference_a = FactoryBot.create(:preference, name: "A")

    expect(Preference.default_order).to eq([preference_a, preference_b])
  end
end

RSpec.describe EntryPreference, type: :model do
  let(:entry) { FactoryBot.create(:entry) }
  let(:preference) { FactoryBot.create(:preference) }

  it "links entries and preferences" do
    entry.preferences << preference

    expect(entry.preferences).to include(preference)
    expect(preference.entries).to include(entry)
  end
end

RSpec.describe Entry, type: :model do
  it "allows zero or many preferences" do
    entry = FactoryBot.create(:entry)
    expect(entry.preferences).to be_empty

    preferences = FactoryBot.create_list(:preference, 2)
    entry.preference_ids = preferences.map(&:id)
    entry.save!

    expect(entry.reload.preferences).to match_array(preferences)
  end
end
