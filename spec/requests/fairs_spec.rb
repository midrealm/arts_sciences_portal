require 'rails_helper'

RSpec.describe "Fairs", type: :request do
  describe "GET /fairs" do
    it "works! (now write some real specs)" do
      get fairs_path
      expect(response).to have_http_status(200)
    end
  end
end
