# encoding: UTF-8
class Account < ActiveRecord::Base
  belongs_to :user
  has_one :planning, dependent: :destroy

  validates_presence_of :uid, :provider
  validates_uniqueness_of :uid, scope: :provider

end
