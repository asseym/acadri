require "rails_helper"

RSpec.describe RfqsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/rfqs").to route_to("rfqs#index")
    end

    it "routes to #new" do
      expect(:get => "/rfqs/new").to route_to("rfqs#new")
    end

    it "routes to #show" do
      expect(:get => "/rfqs/1").to route_to("rfqs#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/rfqs/1/edit").to route_to("rfqs#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/rfqs").to route_to("rfqs#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/rfqs/1").to route_to("rfqs#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/rfqs/1").to route_to("rfqs#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/rfqs/1").to route_to("rfqs#destroy", :id => "1")
    end

  end
end
