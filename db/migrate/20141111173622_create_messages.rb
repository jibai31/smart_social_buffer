class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.references :content, index: true
      t.text :text, null: false
      t.string :social_network, null: false
      t.integer :post_counter, null: false, default: 0
      t.datetime :last_posted_at
      t.boolean :post_only_once, null: false, default: false

      t.timestamps
    end
  end
end
