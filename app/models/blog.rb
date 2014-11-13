class Blog < ActiveRecord::Base
  belongs_to :user
  belongs_to :category

  validates_presence_of :url

  def to_s
    name || url
  end
end
