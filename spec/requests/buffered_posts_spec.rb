require 'rails_helper'

RSpec.describe "BufferedPosts", :type => :request do
  describe "GET /buffered_posts" do
    it "works! (now write some real specs)" do
      get buffered_posts_path
      expect(response).to have_http_status(200)
    end
  end
end
