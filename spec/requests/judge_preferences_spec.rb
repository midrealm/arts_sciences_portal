require 'rails_helper'

RSpec.describe "JudgePreferences", type: :request do
  describe "GET /judge_preferences" do
    it "works! (now write some real specs)" do
      get judge_preferences_path
      expect(response).to have_http_status(200)
    end
  end
end
