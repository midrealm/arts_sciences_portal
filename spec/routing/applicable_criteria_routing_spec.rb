require "rails_helper"

RSpec.describe ApplicableCriteriaController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(:get => "/applicable_criteria").to route_to("applicable_criteria#index")
    end

    it "routes to #new" do
      expect(:get => "/applicable_criteria/new").to route_to("applicable_criteria#new")
    end

    it "routes to #show" do
      expect(:get => "/applicable_criteria/1").to route_to("applicable_criteria#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/applicable_criteria/1/edit").to route_to("applicable_criteria#edit", :id => "1")
    end


    it "routes to #create" do
      expect(:post => "/applicable_criteria").to route_to("applicable_criteria#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/applicable_criteria/1").to route_to("applicable_criteria#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/applicable_criteria/1").to route_to("applicable_criteria#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/applicable_criteria/1").to route_to("applicable_criteria#destroy", :id => "1")
    end
  end
end
