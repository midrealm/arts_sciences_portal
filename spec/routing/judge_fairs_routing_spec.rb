require "rails_helper"

RSpec.describe JudgeFairsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(:get => "/judge_fairs").to route_to("judge_fairs#index")
    end

    it "routes to #new" do
      expect(:get => "/judge_fairs/new").to route_to("judge_fairs#new")
    end

    it "routes to #show" do
      expect(:get => "/judge_fairs/1").to route_to("judge_fairs#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/judge_fairs/1/edit").to route_to("judge_fairs#edit", :id => "1")
    end


    it "routes to #create" do
      expect(:post => "/judge_fairs").to route_to("judge_fairs#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/judge_fairs/1").to route_to("judge_fairs#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/judge_fairs/1").to route_to("judge_fairs#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/judge_fairs/1").to route_to("judge_fairs#destroy", :id => "1")
    end
  end
end
