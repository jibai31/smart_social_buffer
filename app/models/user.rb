class User < ActiveRecord::Base
  # Concerns
  include Authenticatable

  # Associations
  has_many :authentications, dependent: :destroy

  # Devise
  devise :database_authenticatable, :registerable, # :confirmable, :lockable, :timeoutable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:google_oauth2, :facebook, :twitter]

end
