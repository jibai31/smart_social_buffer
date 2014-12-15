require 'rails_helper'
require 'support/buffer_macros'
RSpec.configure{|c| c.include BufferMacros}

describe TwitterContentSelector do

  let(:user)    { create(:user_with_account) }
  let(:account) { user.accounts.first }
  let(:week)    { build_test_week }
  let(:day)     { week.buffered_days.first }

  before(:each) do
    @balancer = TwitterWeekLoadBalancer.new(week, account, test_today)
    @service = TwitterContentSelector.new(account, @balancer)
  end

  context "for many contents" do
    before(:each) do
      user.contents << create_list(:content_with_messages, 12, number_of_messages: 1)
    end

    it "returns the requested number of contents" do
      top_contents = @service.get_top_contents(day, 4)
      expect(top_contents.size).to eq 4
    end

    it "raises an exception when requesting too many contents" do
      expect{@service.get_top_contents(day, 24)}.to raise_error(ArgumentError)
    end

    it "returns nothing when requesting 0 content" do
      top_contents = @service.get_top_contents(day, 0)
      expect(top_contents).to eq []
    end
  end

  describe "priorities" do
    before(:each) do
      @less_posted_content = create(:content_with_messages, posts_count: 0)
      @most_posted_content = create(:content_with_messages, posts_count: 3)
      user.contents << @most_posted_content
      user.contents << @less_posted_content
    end

    it "returns the less posted contents" do
      top_content = @service.get_top_contents(day, 1).first
      expect(top_content).to eq @less_posted_content
    end

    it "skipps contents posted yesterday" do
      yesterday_content = @service.get_top_contents(day, 1).first
      expect(yesterday_content).to eq @less_posted_content

      today_content = @service.get_top_contents(day, 1).first
      expect(today_content).to eq @most_posted_content

      tomorrow_content = @service.get_top_contents(day, 1).first
      expect(tomorrow_content).to eq @less_posted_content
    end
  end

  describe "rules" do
    it "cannot post a content more than 3 times" do
      @c1 = create(:content_with_messages, posts_count: 0)
      @c2 = create(:content_with_messages, posts_count: 1)
      @c3 = create(:content_with_messages, posts_count: 2)
      user.contents << [@c1, @c2, @c3]
      expect(@balancer.perform).to eq [2, 1, 2, 1, 1, 1, 1]

      # Day 1
      contents = @service.get_top_contents(day, 2)
      expect(contents).to eq [@c1, @c2]  # 1-2-2
      # Day 2
      contents = @service.get_top_contents(day, 1)
      expect(contents).to eq [@c3]       # 1-2-3
      # Day 3
      contents = @service.get_top_contents(day, 2)
      expect(contents).to eq [@c1, @c2]  # 2-3-3
      # Day 4
      contents = @service.get_top_contents(day, 1)
      expect(contents).to eq [@c3]       # 2-3-4
      # Day 5
      contents = @service.get_top_contents(day, 1)
      expect(contents).to eq [@c1]       # 3-3-4
      # Day 6
      contents = @service.get_top_contents(day, 1)
      expect(contents).to eq [@c2]       # 3-4-4
      # Day 7 - cannot post c1 or c2 as already posted 3 times
      contents = @service.get_top_contents(day, 1)
      expect(contents).to eq [@c3]       # 3-4-5
    end

    it "cannot post a content twice in a day" do
      @c1 = create(:content_with_messages, posts_count: 0, number_of_messages: 3)
      @c2 = create(:content_with_messages, posts_count: 1, number_of_messages: 3)
      @c3 = create(:content_with_messages, posts_count: 2, number_of_messages: 3)
      @c4 = create(:content_with_messages, posts_count: 3, number_of_messages: 3)
      @c5 = create(:content_with_messages, posts_count: 25, number_of_messages: 2)
      user.contents << [@c1, @c2, @c3, @c4, @c5]
      expect(@balancer.perform).to eq [2, 2, 2, 2, 2, 2, 2]

      # Day 1 to 6
      @service.get_top_contents(day, 2)
      @service.get_top_contents(day, 2)
      @service.get_top_contents(day, 2)
      @service.get_top_contents(day, 2)
      @service.get_top_contents(day, 2)
      @service.get_top_contents(day, 2)

      # Day 7 - only c5 left to post twice, so post only once instead
      contents = @service.get_top_contents(day, 2)
      expect(contents).to eq [@c5]
    end

    it "cannot post more than there are messages" do
      @c1 = create(:content_with_messages, posts_count: 0, number_of_messages: 2)
      @c2 = create(:content_with_messages, posts_count: 1, number_of_messages: 2)
      @c3 = create(:content_with_messages, posts_count: 2, number_of_messages: 2)
      @c4 = create(:content_with_messages, posts_count: 4, number_of_messages: 2)
      @c5 = create(:content_with_messages, posts_count: 5, number_of_messages: 2)
      user.contents << [@c1, @c2, @c3, @c4, @c5]
      expect(@balancer.perform).to eq [2, 1, 2, 1, 2, 1, 1]

      # Day 1
      contents = @service.get_top_contents(day, 2)
      expect(contents).to eq [@c1, @c2]  # 1-2-2-4-5
      # Day 2
      contents = @service.get_top_contents(day, 1)
      expect(contents).to eq [@c3]       # 1-2-3-4-5
      # Day 3
      contents = @service.get_top_contents(day, 2)
      expect(contents).to eq [@c1, @c2]  # 2-3-3-4-5
      # Day 4 - cannot post c1 or c2 as already posted yesterday
      contents = @service.get_top_contents(day, 1)
      expect(contents).to eq [@c3]       # 2-3-4-4-5
      # Day 5 - cannot post c1 or c2 as already posted twice
      contents = @service.get_top_contents(day, 2)
      expect(contents).to eq [@c4, @c5]  # 2-3-4-5-6
      # Day 6 - has to post c4 although posted yesterday
      contents = @service.get_top_contents(day, 1)
      expect(contents).to eq [@c4]       # 2-3-4-6-6
      # Day 7
      contents = @service.get_top_contents(day, 1)
      expect(contents).to eq [@c5]       # 2-3-4-6-7
    end
  end
end
