require 'rails_helper'

RSpec.describe "contents/new", :type => :view do
  before(:each) do
    assign(:content, Content.new(
      :title => "MyString",
      :url => "MyString",
      :activated => false,
      :post_only_once => false
    ))
  end

  it "renders new content form" do
    render

    assert_select "form[action=?][method=?]", contents_path, "post" do

      assert_select "input#content_title[name=?]", "content[title]"

      assert_select "input#content_url[name=?]", "content[url]"

      assert_select "input#content_activated[name=?]", "content[activated]"

      assert_select "input#content_post_only_once[name=?]", "content[post_only_once]"
    end
  end
end
