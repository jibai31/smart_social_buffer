class CreateBufferedPosts < ActiveRecord::Migration
  def change
    create_table :buffered_posts do |t|
      t.references :buffered_day, index: true
      t.references :message, index: true
      t.datetime :run_at

      t.timestamps
    end
  end
end
