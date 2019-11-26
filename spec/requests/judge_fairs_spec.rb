require 'rails_helper'

RSpec.describe "JudgeFairs", type: :request do
  describe "GET /judge_fairs" do
    it "works! (now write some real specs)" do
      get judge_fairs_path
      expect(response).to have_http_status(200)
    end
  end
end
