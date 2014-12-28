class CreateSocialNetworks < ActiveRecord::Migration
  def change
    create_table :social_networks do |t|
      t.string :provider
      t.string :name
      t.boolean :implemented, null: false, default: false

      t.timestamps
    end
    add_index :social_networks, :provider
    add_index :social_networks, :implemented

    SocialNetwork.create([
      {provider: 'twitter', name: 'twitter', implemented: true},
      {provider: 'facebook', name: 'facebook'},
      {provider: 'google_oauth2', name: 'google'},
      {provider: 'linkedin', name: 'linkedin'}
    ])
  end
end
