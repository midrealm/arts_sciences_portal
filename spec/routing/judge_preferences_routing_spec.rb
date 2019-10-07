require "rails_helper"

RSpec.describe JudgePreferencesController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(:get => "/judge_preferences").to route_to("judge_preferences#index")
    end

    it "routes to #new" do
      expect(:get => "/judge_preferences/new").to route_to("judge_preferences#new")
    end

    it "routes to #show" do
      expect(:get => "/judge_preferences/1").to route_to("judge_preferences#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/judge_preferences/1/edit").to route_to("judge_preferences#edit", :id => "1")
    end


    it "routes to #create" do
      expect(:post => "/judge_preferences").to route_to("judge_preferences#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/judge_preferences/1").to route_to("judge_preferences#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/judge_preferences/1").to route_to("judge_preferences#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/judge_preferences/1").to route_to("judge_preferences#destroy", :id => "1")
    end
  end
end
