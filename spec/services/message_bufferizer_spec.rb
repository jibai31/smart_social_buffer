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

    expect(service.buffered_posts.count).to eq(30)
  end

end

describe BufferWeek do
  let(:week) {BufferWeek.new(Date.today)}
  it "creates a days array" do
    expect(week.days.size).to eq(5)
    expect(week.days.first).to eq(Date.today)
  end

  it "creates a buffer array" do
    expect(week.buffer.size).to eq(5)
    expect(week.buffer.first).to eq([])
  end

  describe "schedule" do
    it "fills the buffer" do
      content = create(:content_with_messages)
      week.schedule(content)
      expect(week.buffer.map{|buffered_contents| buffered_contents.size}).to eq [1, 0, 1, 0, 1]
    end

    it "adds to existing buffered contents" do
      content = create(:content_with_messages)
      content2 = create(:content_with_messages)
      week.schedule(content)
      week.schedule(content2)

      expect(week.buffer.map{|buffered_contents| buffered_contents.size}).to eq [2, 1, 1, 1, 1]
    end
  end
end
