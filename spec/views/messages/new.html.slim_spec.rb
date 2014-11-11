require 'rails_helper'

RSpec.describe "messages/new", :type => :view do
  before(:each) do
    assign(:message, Message.new(
      :content => nil,
      :text => "MyText",
      :social_network => "MyString",
      :post_counter => 1,
      :post_only_once => false
    ))
  end

  it "renders new message form" do
    render

    assert_select "form[action=?][method=?]", messages_path, "post" do

      assert_select "input#message_content_id[name=?]", "message[content_id]"

      assert_select "textarea#message_text[name=?]", "message[text]"

      assert_select "input#message_social_network[name=?]", "message[social_network]"

      assert_select "input#message_post_counter[name=?]", "message[post_counter]"

      assert_select "input#message_post_only_once[name=?]", "message[post_only_once]"
    end
  end
end
