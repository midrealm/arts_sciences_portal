require 'rails_helper'

RSpec.describe "JudgeAssigns", type: :request do
  describe "GET /judge_assigns" do
    it "works! (now write some real specs)" do
      get judge_assigns_path
      expect(response).to have_http_status(200)
    end
  end
end
