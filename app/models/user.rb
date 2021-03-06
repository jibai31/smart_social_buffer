# encoding: UTF-8
class User < ActiveRecord::Base
  # Concerns
  include Authenticatable
  include HasContents

  # Associations
  has_many :accounts, dependent: :destroy
  has_many :blogs, dependent: :destroy

  # Devise
  devise :database_authenticatable, :registerable, # :confirmable, :lockable, :timeoutable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:google_oauth2, :facebook, :twitter, :linkedin]

  def password_required?
    (accounts.empty? || !password.blank?) && super
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
