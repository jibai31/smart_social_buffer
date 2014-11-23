require 'rails_helper'

describe TwitterWeekLoadBalancer do

  let(:user)    { create(:user_with_account) }
  let(:account) { user.accounts.first }
  let(:week)    { BufferedWeekFactory.new(account.planning).build }
  let(:service) { TwitterWeekLoadBalancer.new(week, account) }

  it "loads nothing for no content" do
    expect(service.perform).to eq [0, 0, 0, 0, 0, 0, 0]
  end

  describe "with single-message contents" do
    it "loads 1 day for 1 content" do
      user.contents << create_list(:content_with_one_message, 1)
      expect(service.perform).to eq [0, 0, 0, 1, 0, 0, 0]
    end

    it "loads 2 days for 2 contents" do
      user.contents << create_list(:content_with_one_message, 2)
      expect(service.perform).to eq [0, 0, 1, 0, 1, 0, 0]
    end

    it "loads 3 days for 3 contents" do
      user.contents << create_list(:content_with_one_message, 3)
      expect(service.perform).to eq [0, 1, 0, 1, 0, 1, 0]
    end

    it "loads 4 days for 4 contents" do
      user.contents << create_list(:content_with_one_message, 4)
      expect(service.perform).to eq [1, 0, 1, 0, 1, 0, 1]
    end

    it "loads 5 days for 5 contents" do
      user.contents << create_list(:content_with_one_message, 5)
      expect(service.perform).to eq [1, 1, 1, 0, 1, 0, 1]
    end

    it "loads 6 days for 6 contents" do
      user.contents << create_list(:content_with_one_message, 6)
      expect(service.perform).to eq [1, 1, 1, 1, 1, 0, 1]
    end

    it "loads 7 days for 7 contents" do
      user.contents << create_list(:content_with_one_message, 7)
      expect(service.perform).to eq [1, 1, 1, 1, 1, 1, 1]
    end

    it "loads days in a balanced way for many contents" do
      user.contents << create_list(:content_with_one_message, 43)
      expect(service.perform).to eq [7, 6, 6, 6, 6, 6, 6]
    end
  end

  it "limits to 3 messages per content" do
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
