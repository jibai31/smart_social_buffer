require 'rails_helper'

RSpec.describe "contents/edit", :type => :view do
  before(:each) do
    @content = assign(:content, Content.create!(
      :title => "MyString",
      :url => "MyString",
      :activated => false,
      :post_only_once => false
    ))
  end

  it "renders the edit content form" do
    render

    assert_select "form[action=?][method=?]", content_path(@content), "post" do

      assert_select "input#content_title[name=?]", "content[title]"

      assert_select "input#content_url[name=?]", "content[url]"

      assert_select "input#content_activated[name=?]", "content[activated]"

      assert_select "input#content_post_only_once[name=?]", "content[post_only_once]"
    end
  end
end
