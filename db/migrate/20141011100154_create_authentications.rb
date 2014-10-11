class CreateAuthentications < ActiveRecord::Migration
  def change
    create_table :authentications do |t|
      t.references :user, index: true
      t.string :provider
      t.string :uid
      t.string :token
      t.string :token_secret
    end
    add_index :authentications, [:provider, :uid]
  end
end
