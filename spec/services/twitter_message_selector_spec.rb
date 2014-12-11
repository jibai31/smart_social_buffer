require 'rails_helper'

describe TwitterMessageSelector do
  
  let(:user)    { create(:user_with_account) }
  let(:account) { user.accounts.first }
  let(:service) { TwitterMessageSelector.new(account) }
  let(:content) { create(:content_with_posted_messages) }


  it "returns a message from the content" do
    user.contents << content
    m = service.best_message(content)
    expect(content.messages.include?(m)).to be true
  end

  it "returns the less posted message" do
    user.contents << content
    less_posted_message = content.messages.order(:posts_count).first
    m = service.best_message(content)
    expect(m).to eq less_posted_message
  end

  it "cannot post a message twice in a week" do
    c1 = create(:content)
    c1.messages << create(:message, posts_count: 1)
    c1.messages << create(:message, posts_count: 1)
    user.contents << c1

    m1 = service.best_message(c1)
    m2 = service.best_message(c1)

    expect(m1).not_to eq(m2)
  end
end
