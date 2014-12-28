# encoding: UTF-8
class Account < ActiveRecord::Base
  belongs_to :user
  belongs_to :social_network

  # Planning
  has_one :planning, dependent: :destroy
  after_create :create_planning

  validates_presence_of :uid, :social_network_id
  validates_uniqueness_of :uid, scope: :social_network_id

  delegate :contents, to: :user
  delegate :provider, to: :social_network

  scope :implemented, -> { joins(:social_network).where(social_networks: {implemented: true}) }

  def self.find_by_provider_and_uid(provider, uid)
    joins(:social_network).where(social_networks: {provider: provider}).where(uid: uid).first
  end

  def name
    if provider == 'twitter'
      "@#{username}"
    else
      username
    end
  end
end
