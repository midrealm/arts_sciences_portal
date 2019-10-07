require "rails_helper"

RSpec.describe FairsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(:get => "/fairs").to route_to("fairs#index")
    end

    it "routes to #new" do
      expect(:get => "/fairs/new").to route_to("fairs#new")
    end

    it "routes to #show" do
      expect(:get => "/fairs/1").to route_to("fairs#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/fairs/1/edit").to route_to("fairs#edit", :id => "1")
    end


    it "routes to #create" do
      expect(:post => "/fairs").to route_to("fairs#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/fairs/1").to route_to("fairs#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/fairs/1").to route_to("fairs#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/fairs/1").to route_to("fairs#destroy", :id => "1")
    end
  end
end
