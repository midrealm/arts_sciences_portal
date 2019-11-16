require 'rails_helper'

RSpec.describe "ApplicableCriteria", type: :request do
  describe "GET /applicable_criteria" do
    it "works! (now write some real specs)" do
      get applicable_criteria_path
      expect(response).to have_http_status(200)
    end
  end
end
