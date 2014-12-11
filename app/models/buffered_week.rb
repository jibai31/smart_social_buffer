class BufferedWeek < ActiveRecord::Base
  belongs_to :planning
  has_many :buffered_days, dependent: :destroy
  has_many :buffered_posts, through: :buffered_days

  def posts_count
    BufferedPost.where(buffered_day_id: buffered_days.pluck(:id)).count
  end
end
