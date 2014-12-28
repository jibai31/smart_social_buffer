class AddSocialNetworkIndexes < ActiveRecord::Migration
  def change
    remove_index :accounts, "old_provider_and_uid"
    add_index :accounts, :social_network_id
    add_index :messages, :social_network_id
  end
end
