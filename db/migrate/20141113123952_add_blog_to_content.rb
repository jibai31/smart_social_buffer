class AddBlogToContent < ActiveRecord::Migration
  def change
    add_reference :contents, :blog, index: true
  end
end
