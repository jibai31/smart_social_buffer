class CreateAccounts < ActiveRecord::Migration
  def change
    create_table :accounts do |t|
      t.references :user, index: true
      t.string :provider
      t.string :uid
      t.string :token
      t.string :token_secret
      t.string :username
      t.string :email
    end
    add_index :accounts, [:provider, :uid]
  end
end
