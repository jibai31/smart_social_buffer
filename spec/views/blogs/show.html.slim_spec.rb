require 'rails_helper'

RSpec.describe "blogs/show", :type => :view do
  before(:each) do
    @blog = assign(:blog, Blog.create!(
      :name => "Name",
      :url => "Url"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/Url/)
  end
end
