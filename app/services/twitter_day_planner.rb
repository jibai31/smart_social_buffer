# encoding: utf-8
class TwitterDayPlanner

  START_POSTING = 8
  STOP_POSTING = 20

  def initialize(account, message_selector)
    @account = account
    @message_selector = message_selector
  end

  attr_reader :account, :message_selector

  # Spread the contents across the day
  # Return a list of buffered posts
  def perform(day, contents)
    posting_times = compute_posting_times(day, contents) # eg, [9:03, 12:34, 15:25]

    contents.each_with_index do |content, i|
      message = message_selector.best_message(content)
      day.buffered_posts.build(message: message, run_at: posting_times[i])
    end

    day.buffered_posts
  end

  # Posting times methods

  def compute_posting_times(day, contents)
    period = hours_between_posts(contents)
    (1..contents.count).map{|i| randomize(day.day, START_POSTING + i * period)}
  end

  def hours_between_posts(contents)
    (STOP_POSTING - START_POSTING) / (contents.count + 1)
  end

  def randomize(day, hour)
    random_number = rand(-20..20)
    day.to_datetime.change(hour: hour) + random_number.minutes
  end
end
