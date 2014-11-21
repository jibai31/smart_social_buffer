class BufferedDay < ActiveRecord::Base
  belongs_to :buffered_week
  has_many :buffered_posts, dependent: :destroy
end
