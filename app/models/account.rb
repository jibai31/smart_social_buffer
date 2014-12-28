# encoding: UTF-8
class Account < ActiveRecord::Base
  include Publisher

  # Associations
  belongs_to :user
  belongs_to :social_network
  has_one :planning, dependent: :destroy

  # Validations
  validates_presence_of :uid, :social_network_id
  validates_uniqueness_of :uid, scope: :social_network_id

  # Delegates
  delegate :contents, to: :user
  delegate :provider, to: :social_network

  # Callbacks
  after_create :create_planning

  # Scopes
  scope :implemented, -> { joins(:social_network).where(social_networks: {implemented: true}) }

  # Class methods

  def self.find_by_provider_and_uid(provider, uid)
    joins(:social_network).where(social_networks: {provider: provider}).where(uid: uid).first
  end

  # Instance methods

  def name
    if social_network.twitter?
      "@#{username}"
    else
      username
    end
  end

end
