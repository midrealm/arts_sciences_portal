require "rails_helper"

RSpec.describe ScoresheetsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(:get => "/scoresheets").to route_to("scoresheets#index")
    end

    it "routes to #new" do
      expect(:get => "/scoresheets/new").to route_to("scoresheets#new")
    end

    it "routes to #show" do
      expect(:get => "/scoresheets/1").to route_to("scoresheets#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/scoresheets/1/edit").to route_to("scoresheets#edit", :id => "1")
    end


    it "routes to #create" do
      expect(:post => "/scoresheets").to route_to("scoresheets#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/scoresheets/1").to route_to("scoresheets#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/scoresheets/1").to route_to("scoresheets#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/scoresheets/1").to route_to("scoresheets#destroy", :id => "1")
    end
  end
end
