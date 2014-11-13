require 'rails_helper'

RSpec.describe "buffered_posts/edit", :type => :view do
  before(:each) do
    @buffered_post = assign(:buffered_post, BufferedPost.create!(
      :message => "",
      :state => "MyString"
    ))
  end

  it "renders the edit buffered_post form" do
    render

    assert_select "form[action=?][method=?]", buffered_post_path(@buffered_post), "post" do

      assert_select "input#buffered_post_message[name=?]", "buffered_post[message]"

      assert_select "input#buffered_post_state[name=?]", "buffered_post[state]"
    end
  end
end
