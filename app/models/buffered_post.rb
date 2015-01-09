class BufferedPost < ActiveRecord::Base
  belongs_to :buffered_day
  belongs_to :message

  delegate :account, to: :buffered_day

  after_create :schedule_post

  def schedule_post
    account.delay(run_at: run_at).publish(message)
    message.increment_posts_count
    message.content.increment_posts_count
  end
end
