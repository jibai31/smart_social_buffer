require 'rails_helper'

RSpec.describe "buffered_posts/show", :type => :view do
  before(:each) do
    @buffered_post = assign(:buffered_post, BufferedPost.create!(
      :message => "",
      :state => "State"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(/State/)
  end
end
