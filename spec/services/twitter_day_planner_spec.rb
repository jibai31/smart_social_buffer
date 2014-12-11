require 'rails_helper'
require 'support/buffer_macros'
RSpec.configure{|c| c.include BufferMacros}

describe TwitterDayPlanner do

  let(:user)    { create(:user_with_account) }
  let(:account) { user.accounts.first }
  let(:day)     { BufferedWeekFactory.new(account.planning).build.buffered_days.first }
  let(:selector){ TwitterMessageSelector.new(account) }
  let(:service) { TwitterDayPlanner.new(account, selector) }

  it "fills the day with posts" do
    contents = create_list(:content_with_one_message, 2)
    expect(day.buffered_posts.size).to eq 0

    service.perform(day, contents)

    expect(day.buffered_posts.size).to eq 2
  end

  it "spreads posts across the day" do
    contents = create_list(:content_with_one_message, 2)
    
    posts = service.perform(day, contents)
    
    expect(posts.first).to run_around 12
    expect(posts.last).to run_around 16
  end

  it "only selects messages for Twitter" do
    contents = create_list(:content_with_one_message, 2)

    posts = service.perform(day, contents)
    posts.each do |p|
      social_network = p.message.social_network
      expect(social_network).to eq "twitter"
    end
  end

  it "temporary marks messages as posted when selecting them" do
    expect(true).to be_false
  end
end
