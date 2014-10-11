class User < ActiveRecord::Base

  # Associations
  has_many :authentications

  # Devise
  devise :database_authenticatable, :registerable, # :confirmable, :lockable, :timeoutable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:google_oauth2, :facebook, :twitter]
end
