require 'rails_helper'

RSpec.describe Criterium, type: :model do
  describe ".by_type" do
    let!(:criteria_type) {FactoryBot.create(:criteria_type)}
    let!(:criteria) {FactoryBot.create(:criterium, criteria_type: criteria_type, description: 'one')}
    let!(:criteria_incorrect) {FactoryBot.create(:criterium, description: 'two')}

    it "returns only criterium for the current criteria type" do
      criterium = Criterium.by_type(criteria_type.id).pluck(:description)
      expect(criterium).to include('one')
      expect(criterium).to_not include('two')
    end
  end

  describe ".by_category" do
    let!(:category) {FactoryBot.create(:category)}
    let!(:criteria_correct) {FactoryBot.create(:criterium, category: category, description: 'one')}
    let!(:criteria_incorrect) {FactoryBot.create(:criterium, description: 'two')}

    it "returns only criterium for the current category" do
      criterium = Criterium.by_category(category.id).pluck(:description)
      expect(criterium).to include('one')
      expect(criterium).to_not include('two')
    end
  end
end
