require 'rails_helper'

RSpec.describe "blogs/edit", :type => :view do
  before(:each) do
    @blog = assign(:blog, Blog.create!(
      :name => "MyString",
      :url => "MyString"
    ))
  end

  it "renders the edit blog form" do
    render

    assert_select "form[action=?][method=?]", blog_path(@blog), "post" do

      assert_select "input#blog_name[name=?]", "blog[name]"

      assert_select "input#blog_url[name=?]", "blog[url]"
    end
  end
end
