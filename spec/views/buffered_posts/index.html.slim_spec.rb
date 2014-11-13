require 'rails_helper'

RSpec.describe "buffered_posts/index", :type => :view do
  before(:each) do
    assign(:buffered_posts, [
      BufferedPost.create!(
        :message => "",
        :state => "State"
      ),
      BufferedPost.create!(
        :message => "",
        :state => "State"
      )
    ])
  end

  it "renders a list of buffered_posts" do
    render
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "State".to_s, :count => 2
  end
end
