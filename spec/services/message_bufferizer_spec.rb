require 'rails_helper'
require 'load_balancing_array'

describe MessageBufferizer do

  let(:user)    { create(:user_with_account) }
  let(:service) { MessageBufferizer.new(user) }

  before(:each) do
    user.contents << create(:content_with_messages)
    user.contents << create(:content_with_messages)
    user.contents << create(:content_with_messages)
    user.contents << create(:content_with_messages)
    user.contents << create(:content_with_messages)
    user.contents << create(:content_with_messages)
  end

  it "creates BufferedPosts" do
    expect(user.contents.count).to eq(6)
    expect(user.contents.first.messages.count).to eq(5)

    service.preview
    service.print

    expect(service.buffered_posts.count).to eq(18)
  end

  it "makes sure a content is never posted more than 3 times" do
    expect(false).to be true
  end

end

describe BalancedWeek do
  let(:week) {BalancedWeek.new(Date.today)}
  it "creates a days array" do
    expect(week.days.size).to eq(5)
    expect(week.days.first).to eq(Date.today)
  end

  it "creates 5 empty piles" do
    expect(week.piles.size).to eq(5)
    expect(week.piles.first).to eq([])
  end

  describe "schedule" do
    it "fills the buffer" do
      content = create(:content_with_messages)
      week.schedule(content)
      expect(week.pile_sizes).to eq [1, 0, 1, 0, 1]
    end

    it "adds to existing buffered contents" do
      content = create(:content_with_messages)
      content2 = create(:content_with_messages)
      week.schedule(content)
      week.schedule(content2)

      expect(week.pile_sizes).to eq [2, 1, 1, 1, 1]
    end
  end
end
