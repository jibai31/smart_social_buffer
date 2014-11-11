require 'rails_helper'

RSpec.describe "messages/index", :type => :view do
  before(:each) do
    assign(:messages, [
      Message.create!(
        :content => nil,
        :text => "MyText",
        :social_network => "Social Network",
        :post_counter => 1,
        :post_only_once => false
      ),
      Message.create!(
        :content => nil,
        :text => "MyText",
        :social_network => "Social Network",
        :post_counter => 1,
        :post_only_once => false
      )
    ])
  end

  it "renders a list of messages" do
    render
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "Social Network".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
  end
end
