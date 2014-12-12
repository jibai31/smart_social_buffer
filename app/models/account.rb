# encoding: UTF-8
class Account < ActiveRecord::Base
  belongs_to :user
  has_one :planning, dependent: :destroy

  validates_presence_of :uid, :provider
  validates_uniqueness_of :uid, scope: :provider

  delegate :contents, to: :user

  after_create :create_planning

  def self.implemented
    where(provider: ['twitter'])
  end

end
