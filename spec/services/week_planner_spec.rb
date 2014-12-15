require 'rails_helper'
require 'support/buffer_macros'
RSpec.configure{|c| c.include BufferMacros}

describe WeekPlanner do

  let(:user)    { create(:user_with_account) }
  let(:account) { user.accounts.first }
  let(:service) { WeekPlanner.new(account, @week, today: test_today) }

  before(:each) do
    @week = create_test_week
    user.contents << create_list(:content_with_messages, 6, number_of_messages: 5)
  end

  describe "preview" do
    it "builds BufferedPosts" do
      expect(user.contents.count).to eq 6
      expect(user.contents.first.messages.count).to eq 5

      expect(posts_count @week).to eq 0

      service.preview
      # service.print

      expect(posts_count @week).to eq 18
    end

    it "doesn't create anything" do
      service.preview
      expect(@week.posts_count).to eq 0
    end
  end

  describe "perform" do
    it "creates BufferedPosts" do
      service.perform
      expect(@week.posts_count).to eq 18
    end
  end
end
