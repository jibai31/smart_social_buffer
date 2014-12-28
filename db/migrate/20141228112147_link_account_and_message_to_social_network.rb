class LinkAccountAndMessageToSocialNetwork < ActiveRecord::Migration
  def up
    # Account
    rename_column :accounts, :provider, :old_provider
    add_column :accounts, :social_network_id, :integer
    Account.all.each do |account|
      social_id = SocialNetwork.find_by_provider(account.old_provider).id
      account.update_column(:social_network_id, social_id)
    end
    remove_column :accounts, :old_provider
    add_index :accounts, [:social_network_id, :uid]

    # Message
    remove_column :messages, :social_network
    add_column :messages, :social_network_id, :integer

    twitter_id = SocialNetwork.implemented.first.id
    Message.update_all(social_network_id: twitter_id)
  end

  def down
    # Account
    add_column :accounts, :provider, :string
    remove_column :accounts, :social_network_id

    # Message
    remove_column :messages, :social_network_id
    add_column :messages, :social_network, :string
  end
end
