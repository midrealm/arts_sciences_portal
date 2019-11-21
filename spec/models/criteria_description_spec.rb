require 'rails_helper'

RSpec.describe CriteriaDescription, type: :model do
  describe ".by_type" do
    let!(:criteria_type) {FactoryBot.create(:criteria_type)}
    let!(:criteria_desc_correct) {FactoryBot.create(:criteria_description, criteria_type: criteria_type, description: 'one')}
    let!(:criteria_desc_incorrect) {FactoryBot.create(:criteria_description, description: 'two')}

    it "returns only criteria descriptions for the current criteria type" do
      criteria_descs = CriteriaDescription.by_type(criteria_type.id).pluck(:description)
      expect(criteria_descs).to include('one')
      expect(criteria_descs).to_not include('two')
    end
  end

  describe ".by_category" do
    let!(:category) {FactoryBot.create(:category)}
    let!(:criteria_desc_correct) {FactoryBot.create(:criteria_description, category: category, description: 'one')}
    let!(:criteria_desc_incorrect) {FactoryBot.create(:criteria_description, description: 'two')}

    it "returns only criteria descriptions for the current category" do
      criteria_descs = CriteriaDescription.by_category(category.id).pluck(:description)
      expect(criteria_descs).to include('one')
      expect(criteria_descs).to_not include('two')
    end
  end

  describe ".description_for_category" do
    context "when a description for a category exists" do
      let!(:category) {FactoryBot.create(:category)}
      let!(:criteria_type) {FactoryBot.create(:criteria_type)}
      let!(:criteria_desc) {FactoryBot.create(:criteria_description, criteria_type: criteria_type, category: category, description: 'one')}

      it "returns a criteria_description" do
        criteria_desc = CriteriaDescription.description_for_category(criteria_type.id, category.id)
        expect(criteria_desc).to eq('one')
      end
    end

    context "when a description for a category does not exist" do
      let!(:category) {FactoryBot.create(:category)}
      let!(:criteria_type) {FactoryBot.create(:criteria_type)}

      it "returns a criteria_description" do
        criteria_desc = CriteriaDescription.description_for_category(criteria_type.id, category.id)
        expect(criteria_desc).to eq('')
      end
    end
  end
end
