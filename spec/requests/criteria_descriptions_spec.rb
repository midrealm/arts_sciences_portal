require 'rails_helper'

RSpec.describe "CriteriaDescriptions", type: :request do
  describe "GET /criteria_descriptions" do
    it "works! (now write some real specs)" do
      get criteria_descriptions_path
      expect(response).to have_http_status(200)
    end
  end
end
