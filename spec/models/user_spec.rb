require "rails_helper"

RSpec.describe User do
  describe ".admin?" do
    context "an admin user" do
      let(:user) {FactoryBot.create(:user, :admin)}
      it "returns truthy" do
        expect(user.admin?).to be_truthy
      end
    end

    context "a regular user" do
      let(:user) {FactoryBot.create(:user)}
      it "returns falsey" do
        expect(user.admin?).to be_falsey
      end
    end
  end
end
