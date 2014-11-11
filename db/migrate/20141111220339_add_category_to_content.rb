class AddCategoryToContent < ActiveRecord::Migration
  def change
    add_column :blogs, :category_id, :integer
    add_column :contents, :category_id, :integer
  end
end
