class CreateContents < ActiveRecord::Migration
  def change
    create_table :contents do |t|
      t.references :user, index: true
      t.string :title
      t.string :url
      t.boolean :activated, null: false, default: true
      t.boolean :post_only_once, null: false, default: false

      t.timestamps
    end
  end
end
