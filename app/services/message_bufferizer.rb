# encoding: UTF-8
class MessageBufferizer

  def initialize(user)
    @user = user
    @buffered_posts = []
    @potential_contents = user.contents.to_a
    @week = BalancedWeek.new(Date.today)
  end

  attr_reader :user, :buffered_posts, :potential_contents, :week

  # For tests only
  def buffer
    week.piles
  end

  def preview
    # SIMPLIFICATIONS
    #  - only posts between 9AM and 5PM
    #
    # TWITTER ONLY
    #  - target_post_frequency = 1 message per hour
    #  - a message can only be posted once in a week
    #  - a content can only be posted once in a day
    #  - a content can only be posted 3 times in a week
    #  - homogeneous distribution on a week
    #  - homegeneous distribution in a day
    #
    while potential_contents.any?
      next_content = next_priority_content
      week.schedule(next_content)
    end

    bufferize_posts
  end

  def perform
    # Call preview then save
    # Do the magic
  end

  # For tests only

  def bufferize_posts
    week.piles.each do |contents_for_the_day|
      contents_for_the_day.each do |content|
        message = next_priority_message(content)
        time_of_delivery = Time.now
        buffered_posts << BufferedPost.new(message: message, user: user, run_at: time_of_delivery)
      end
    end
  end

  def print
    buffer.each_with_index do |buffered_contents, i|
      puts "Day #{i}: #{week.days[i]} -> #{buffered_contents.count} contents buffered for that day" 
    end
  end

  private

  # Smell : probably needs an iterator object

  def next_priority_message(content)
    content.messages.min_by{|message| message.post_counter}
  end

  def next_priority_content
    content = top_priority_content(potential_contents) 
    potential_contents.delete(content)
  end

  def top_priority_content(contents)
    contents.min_by{|content| content.post_counter}
  end
end

class BalancedWeek < LoadBalancingArray
  def initialize(first_day)
    super(5)
    # Init days of the week: days[3] = Thu, May 23
    @days = [first_day]
    (1..4).each {|nb| @days << first_day + nb.days}
  end

  attr_reader :days

  def schedule(content)
    @MAX_POST_CONTENT_IN_WEEK = 3
    nb_posts = [@MAX_POST_CONTENT_IN_WEEK, content.messages.count].min
    spread(nb_posts.times.collect{content})
  end

end
