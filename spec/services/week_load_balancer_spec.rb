require 'rails_helper'

describe WeekLoadBalancer do

  let(:user)    { create(:user_with_account) }
  let(:account) { user.accounts.first }
  let(:week)    { BufferedWeekFactory.new(account.planning).build }
  let(:service) { WeekLoadBalancer.new(week, account) }

  it "loads nothing for no content" do
    expect(service.perform).to eq [0, 0, 0, 0, 0, 0, 0]
  end

  it "loads 1 day for 1 content" do
    user.contents << build_list(:content_with_messages, 1)
    expect(service.perform).to eq [0, 0, 0, 1, 0, 0, 0]
  end

  it "loads 2 days for 2 contents" do
    user.contents << build_list(:content_with_messages, 2)
    expect(service.perform).to eq [0, 0, 1, 0, 1, 0, 0]
  end

  it "loads 3 days for 3 contents" do
    user.contents << build_list(:content_with_messages, 3)
    expect(service.perform).to eq [0, 1, 0, 1, 0, 1, 0]
  end

  it "loads 4 days for 4 contents" do
    user.contents << build_list(:content_with_messages, 4)
    expect(service.perform).to eq [1, 0, 1, 0, 1, 0, 1]
  end

  it "loads 5 days for 5 contents" do
    user.contents << build_list(:content_with_messages, 5)
    expect(service.perform).to eq [1, 1, 1, 0, 1, 0, 1]
  end

  it "loads 6 days for 6 contents" do
    user.contents << build_list(:content_with_messages, 6)
    expect(service.perform).to eq [1, 1, 1, 1, 1, 0, 1]
  end

  it "loads 7 days for 7 contents" do
    user.contents << build_list(:content_with_messages, 7)
    expect(service.perform).to eq [1, 1, 1, 1, 1, 1, 1]
  end

  it "loads days in a balanced way for many contents" do
    user.contents << build_list(:content_with_messages, 43)
    expect(service.perform).to eq [7, 6, 6, 6, 6, 6, 6]
  end
end
