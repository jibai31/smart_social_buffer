class BufferedWeek < ActiveRecord::Base
  belongs_to :timeline
  has_many :buffered_days, dependent: :destroy
end
