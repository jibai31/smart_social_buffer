class AddSocialNetworkIndexes < ActiveRecord::Migration
  def change
    add_index :accounts, :social_network_id
    add_index :messages, :social_network_id
  end
end
