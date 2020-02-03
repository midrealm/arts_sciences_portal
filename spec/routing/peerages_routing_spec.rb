require "rails_helper"

RSpec.describe PeeragesController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(:get => "/peerages").to route_to("peerages#index")
    end

    it "routes to #new" do
      expect(:get => "/peerages/new").to route_to("peerages#new")
    end

    it "routes to #show" do
      expect(:get => "/peerages/1").to route_to("peerages#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/peerages/1/edit").to route_to("peerages#edit", :id => "1")
    end


    it "routes to #create" do
      expect(:post => "/peerages").to route_to("peerages#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/peerages/1").to route_to("peerages#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/peerages/1").to route_to("peerages#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/peerages/1").to route_to("peerages#destroy", :id => "1")
    end
  end
end
