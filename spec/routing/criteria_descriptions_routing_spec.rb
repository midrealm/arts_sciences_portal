require "rails_helper"

RSpec.describe CriteriaDescriptionsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(:get => "/criteria_descriptions").to route_to("criteria_descriptions#index")
    end

    it "routes to #new" do
      expect(:get => "/criteria_descriptions/new").to route_to("criteria_descriptions#new")
    end

    it "routes to #show" do
      expect(:get => "/criteria_descriptions/1").to route_to("criteria_descriptions#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/criteria_descriptions/1/edit").to route_to("criteria_descriptions#edit", :id => "1")
    end


    it "routes to #create" do
      expect(:post => "/criteria_descriptions").to route_to("criteria_descriptions#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/criteria_descriptions/1").to route_to("criteria_descriptions#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/criteria_descriptions/1").to route_to("criteria_descriptions#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/criteria_descriptions/1").to route_to("criteria_descriptions#destroy", :id => "1")
    end
  end
end
