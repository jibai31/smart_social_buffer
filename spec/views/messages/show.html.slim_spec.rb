require 'rails_helper'

RSpec.describe "messages/show", :type => :view do
  before(:each) do
    @message = assign(:message, Message.create!(
      :content => nil,
      :text => "MyText",
      :social_network => "Social Network",
      :post_counter => 1,
      :post_only_once => false
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/Social Network/)
    expect(rendered).to match(/1/)
    expect(rendered).to match(/false/)
  end
end
