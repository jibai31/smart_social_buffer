require "rails_helper"

RSpec.describe BufferedPostsController, :type => :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/buffered_posts").to route_to("buffered_posts#index")
    end

    it "routes to #new" do
      expect(:get => "/buffered_posts/new").to route_to("buffered_posts#new")
    end

    it "routes to #show" do
      expect(:get => "/buffered_posts/1").to route_to("buffered_posts#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/buffered_posts/1/edit").to route_to("buffered_posts#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/buffered_posts").to route_to("buffered_posts#create")
    end

    it "routes to #update" do
      expect(:put => "/buffered_posts/1").to route_to("buffered_posts#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/buffered_posts/1").to route_to("buffered_posts#destroy", :id => "1")
    end

  end
end
