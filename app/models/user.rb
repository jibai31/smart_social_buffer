class User < ActiveRecord::Base
  # Concerns
  include Authenticatable

  # Associations
  has_many :authentications, dependent: :destroy

  # Devise
  devise :database_authenticatable, :registerable, # :confirmable, :lockable, :timeoutable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:google_oauth2, :facebook, :twitter]

  def password_required?
    (authentications.empty? || !password.blank?) && super
  end

  # OK to update a user without a password (otherwise validation fails)
  def update_with_password(params, *options)
    if encrypted_password.blank?
      update_attributes(params, *options)
    else
      super
    end
  end

end
