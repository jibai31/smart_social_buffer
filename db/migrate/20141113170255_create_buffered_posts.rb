class CreateBufferedPosts < ActiveRecord::Migration
  def change
    create_table :buffered_posts do |t|
      t.references :message, index: true
      t.references :user, index: true
      t.datetime :run_at
      t.string :state, index: true

      t.timestamps
    end
  end
end
