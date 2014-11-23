class AddPostCountToContents < ActiveRecord::Migration
  def change
    add_column :contents, :posts_count, :integer, null: false, default: 0
    rename_column :messages, :post_counter, :posts_count
  end
end
