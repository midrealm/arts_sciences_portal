require "rails_helper"

RSpec.describe UserPeeragesController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(:get => "/user_peerages").to route_to("user_peerages#index")
    end

    it "routes to #new" do
      expect(:get => "/user_peerages/new").to route_to("user_peerages#new")
    end

    it "routes to #show" do
      expect(:get => "/user_peerages/1").to route_to("user_peerages#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/user_peerages/1/edit").to route_to("user_peerages#edit", :id => "1")
    end


    it "routes to #create" do
      expect(:post => "/user_peerages").to route_to("user_peerages#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/user_peerages/1").to route_to("user_peerages#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/user_peerages/1").to route_to("user_peerages#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/user_peerages/1").to route_to("user_peerages#destroy", :id => "1")
    end
  end
end
