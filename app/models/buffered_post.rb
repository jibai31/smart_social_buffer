class BufferedPost < ActiveRecord::Base
  belongs_to :buffered_day
  belongs_to :message
end
