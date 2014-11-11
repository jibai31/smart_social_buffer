require 'rails_helper'

RSpec.describe "contents/show", :type => :view do
  before(:each) do
    @content = assign(:content, Content.create!(
      :title => "Title",
      :url => "Url",
      :activated => false,
      :post_only_once => false
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Title/)
    expect(rendered).to match(/Url/)
    expect(rendered).to match(/false/)
    expect(rendered).to match(/false/)
  end
end
