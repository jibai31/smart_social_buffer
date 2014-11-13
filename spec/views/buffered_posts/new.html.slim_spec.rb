require 'rails_helper'

RSpec.describe "buffered_posts/new", :type => :view do
  before(:each) do
    assign(:buffered_post, BufferedPost.new(
      :message => "",
      :state => "MyString"
    ))
  end

  it "renders new buffered_post form" do
    render

    assert_select "form[action=?][method=?]", buffered_posts_path, "post" do

      assert_select "input#buffered_post_message[name=?]", "buffered_post[message]"

      assert_select "input#buffered_post_state[name=?]", "buffered_post[state]"
    end
  end
end
