require "rails_helper"

RSpec.describe JudgeAssignsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(:get => "/judge_assigns").to route_to("judge_assigns#index")
    end

    it "routes to #new" do
      expect(:get => "/judge_assigns/new").to route_to("judge_assigns#new")
    end

    it "routes to #show" do
      expect(:get => "/judge_assigns/1").to route_to("judge_assigns#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/judge_assigns/1/edit").to route_to("judge_assigns#edit", :id => "1")
    end


    it "routes to #create" do
      expect(:post => "/judge_assigns").to route_to("judge_assigns#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/judge_assigns/1").to route_to("judge_assigns#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/judge_assigns/1").to route_to("judge_assigns#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/judge_assigns/1").to route_to("judge_assigns#destroy", :id => "1")
    end
  end
end
