require 'rails_helper'

RSpec.describe "UserPeerages", type: :request do
  describe "GET /user_peerages" do
    it "works! (now write some real specs)" do
      get user_peerages_path
      expect(response).to have_http_status(200)
    end
  end
end
