require 'rails_helper'
require 'support/buffer_macros'
RSpec.configure{|c| c.include BufferMacros}

describe TwitterWeekLoadBalancer do

  let(:user)      { create(:user_with_account) }
  let(:account)   { user.accounts.first }
  let(:week)      { build_test_week }
  let(:service)   { TwitterWeekLoadBalancer.new(week, account, test_today) }

  let(:middle_day){ Date.new(2014, 12, 17) }
  let(:last_day)  { Date.new(2014, 12, 21) }
  let(:after_day) { Date.new(2014, 12, 22) }
  let(:first_day) { Date.new(2014, 12, 15) }

  it "loads nothing for no content" do
    expect(service.perform).to eq [0, 0, 0, 0, 0, 0, 0]
  end

  describe "if we're on the middle of the week" do
    let(:service) { TwitterWeekLoadBalancer.new(week, account, middle_day) }

    it "loads nothing for the past days" do
      user.contents << create_list(:content_with_messages, 9)
      expect(service.perform).to eq [0, 0, 0, 4, 4, 3, 4]
    end
  end

  describe "if we're on the last day of the week" do
    let(:service) { TwitterWeekLoadBalancer.new(week, account, last_day) }

    it "loads nothing" do
      user.contents << create_list(:content_with_messages, 9)
      expect(service.perform).to eq [0, 0, 0, 0, 0, 0, 0]
    end
  end

  describe "if we're on the first day of the week" do
    let(:service) { TwitterWeekLoadBalancer.new(week, account, first_day) }

    it "loads nothing for the first day" do
      user.contents << create_list(:content_with_messages, 9)
      expect(service.perform).to eq [0, 4, 4, 4, 4, 3, 4]
    end
  end

  describe "if we're after the week" do
    let(:service) { TwitterWeekLoadBalancer.new(week, account, after_day) }

    it "loads nothing" do
      user.contents << create_list(:content_with_messages, 9)
      expect(service.perform).to eq [0, 0, 0, 0, 0, 0, 0]
    end
  end

  describe "with single-message contents" do
    it "loads 1 day for 1 content" do
      user.contents << create_list(:content_with_messages, 1, number_of_messages: 1)
      expect(service.perform).to eq [0, 0, 0, 1, 0, 0, 0]
    end

    it "loads 2 days for 2 contents" do
      user.contents << create_list(:content_with_messages, 2, number_of_messages: 1)
      expect(service.perform).to eq [0, 0, 1, 0, 1, 0, 0]
    end

    it "loads 3 days for 3 contents" do
      user.contents << create_list(:content_with_messages, 3, number_of_messages: 1)
      expect(service.perform).to eq [0, 1, 0, 1, 0, 1, 0]
    end

    it "loads 4 days for 4 contents" do
      user.contents << create_list(:content_with_messages, 4, number_of_messages: 1)
      expect(service.perform).to eq [1, 0, 1, 0, 1, 0, 1]
    end

    it "loads 5 days for 5 contents" do
      user.contents << create_list(:content_with_messages, 5, number_of_messages: 1)
      expect(service.perform).to eq [1, 1, 1, 0, 1, 0, 1]
    end

    it "loads 6 days for 6 contents" do
      user.contents << create_list(:content_with_messages, 6, number_of_messages: 1)
      expect(service.perform).to eq [1, 1, 1, 1, 1, 0, 1]
    end

    it "loads 7 days for 7 contents" do
      user.contents << create_list(:content_with_messages, 7, number_of_messages: 1)
      expect(service.perform).to eq [1, 1, 1, 1, 1, 1, 1]
    end

    it "loads days in a balanced way for many contents" do
      user.contents << create_list(:content_with_messages, 43, number_of_messages: 1)
      expect(service.perform).to eq [7, 6, 6, 6, 6, 6, 6]
    end
  end

  it "can only post a content 3 times in a week" do
    user.contents << create_list(:content_with_messages, 1)
    expect(service.perform).to eq [0, 1, 0, 1, 0, 1, 0]
  end

  it "loads days in a balanced way for many contents" do
    user.contents << create_list(:content_with_messages, 9)
    expect(service.perform).to eq [4, 4, 4, 4, 4, 3, 4]
  end

  it "limits to 12 messages per day" do
    user.contents << create_list(:content_with_messages, 30)
    expect(service.perform).to eq [12, 12, 12, 12, 12, 12, 12]
  end
end
