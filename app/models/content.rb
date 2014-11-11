class Content < ActiveRecord::Base
  belongs_to :user
  belongs_to :category
  has_many :messages, dependent: :destroy

  validates_presence_of :url
end
