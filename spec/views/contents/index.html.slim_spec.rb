require 'rails_helper'

RSpec.describe "contents/index", :type => :view do
  before(:each) do
    assign(:contents, [
      Content.create!(
        :title => "Title",
        :url => "Url",
        :activated => false,
        :post_only_once => false
      ),
      Content.create!(
        :title => "Title",
        :url => "Url",
        :activated => false,
        :post_only_once => false
      )
    ])
  end

  it "renders a list of contents" do
    render
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    assert_select "tr>td", :text => "Url".to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
  end
end
