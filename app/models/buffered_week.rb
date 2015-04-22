class BufferedWeek < ActiveRecord::Base
  belongs_to :planning
  has_many :buffered_days, -> {order :day}, dependent: :destroy
  has_many :buffered_posts, through: :buffered_days

  delegate :account, to: :planning

  def posts_count
    BufferedPost.where(buffered_day_id: buffered_days.pluck(:id)).count
  end

  def preview_posts_count
    buffered_days.inject(0){|sum, day| sum + day.buffered_posts.size}
  end

  def empty?
    posts_count == 0
  end

  def can_preview?
    preview_posts_count == 0 && before_sunday?
  end


  def can_plan?
    empty? && before_sunday?
  end

  def cannot_plan?
    !can_plan?
  end

  def before_sunday?
    Date.today < first_day + 6.days
  end

  def past?
    !before_sunday?
  end
end
