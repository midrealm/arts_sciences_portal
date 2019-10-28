require "rails_helper"

RSpec.describe CriteriaTypesController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(:get => "/criteria_types").to route_to("criteria_types#index")
    end

    it "routes to #new" do
      expect(:get => "/criteria_types/new").to route_to("criteria_types#new")
    end

    it "routes to #show" do
      expect(:get => "/criteria_types/1").to route_to("criteria_types#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/criteria_types/1/edit").to route_to("criteria_types#edit", :id => "1")
    end


    it "routes to #create" do
      expect(:post => "/criteria_types").to route_to("criteria_types#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/criteria_types/1").to route_to("criteria_types#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/criteria_types/1").to route_to("criteria_types#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/criteria_types/1").to route_to("criteria_types#destroy", :id => "1")
    end
  end
end
