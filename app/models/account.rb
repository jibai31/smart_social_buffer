# encoding: UTF-8
class Account < ActiveRecord::Base
  belongs_to :user

  # Planning
  has_one :planning, dependent: :destroy
  after_create :create_planning

  validates_presence_of :uid, :provider
  validates_uniqueness_of :uid, scope: :provider

  delegate :contents, to: :user

  def self.implemented
    where(provider: ['twitter'])
  end

  def name
    if provider == 'twitter'
      "@#{username}"
    else
      username
    end
  end
end
