describe MessageBufferizer do

  let(:user)    { create(:user_with_account) }
  let(:service) { MessageBufferizer.new(user) }

  before(:each) do
    user.contents << create(:content_with_messages)
  end

  it "creates BufferedPosts" do
    expect(user.contents.count).to eq(1)
    expect(user.contents.first.messages.count).to eq(5)

    service.preview

    expect(service.buffered_posts.count).to eq(5)
  end
  
end
