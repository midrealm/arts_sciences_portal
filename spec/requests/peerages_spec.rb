require 'rails_helper'

RSpec.describe "Peerages", type: :request do
  describe "GET /peerages" do
    it "works! (now write some real specs)" do
      get peerages_path
      expect(response).to have_http_status(200)
    end
  end
end
