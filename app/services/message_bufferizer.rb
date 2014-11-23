# encoding: UTF-8
class MessageBufferizer

  def initialize(account, week, args = {})
    # Data
    @account = account
    @week = week

    # Services
    @week_load_balancer = args[:week_load_balancer] || WeekLoadBalancerFactory.new(account).build(week)
    @day_load_balancer = args[:day_load_balancer] || DayLoadBalancerFactory.new(account).build(day)
    @content_selector = args[:content_selector] || ContentSelectorFactory.new(account).build(@week_load_balancer)
    @message_selector = args[:message_selector] || MessageSelectorFactory.new(account).build

    # Init
    @nb_contents_by_day = week_load_balancer.perform(week, account)
  end

  # attr_reader :user, :buffered_posts, :potential_contents, :week
  attr_reader :account, :week, :week_load_balancer, :day_load_balancer, :content_selector, :message_selector,
    :nb_contents_by_day

  def preview
    # SIMPLIFICATIONS
    #  - only posts between 8AM and 8PM
    #
    # TWITTER ONLY : target_post_frequency = 1 message per hour 
    #
    #  - a message can only be posted once in a week     [x] Week Load Balancer
    #  - a content can only be posted once in a day      [ ]
    #  - a content can only be posted 3 times in a week  [x] Week Load Balancer
    #  - less than 1 msg/h = 12 msg/day = 84 msg/week    [x] Week Load Balancer
    #  - homogeneous distribution on a week              [x] Week Load Balancer
    #  - homegeneous distribution in a day               [ ]
    #

    week.buffered_days.each_with_index do |day, day_position|
      day_capacity = nb_contents_by_day[day_position]
      top_contents = content_selector.get_top_contents(day, day_capacity)

      day_posting_times = day_load_balancer.perform(day, best_contents)

      best_contents.each_with_index do |content, content_position|
        best_message = message_selector.get_best_message(content)
        post = day.buffered_posts.build(message: best_message, run_at: day_posting_times[content_position])
      end
    end

  end

  def perform
    preview
    week.save
  end

  # For tests only ####################################################

  def buffer
    week.piles
  end

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

  # NEW PRIVATE METHODS (DELETE THE OTHER ONES LATER)


  # OLD PRIVATE METHODS ! DELETE WHEN DONE !


  # Smell : probably needs an iterator object
  def next_priority_message(content)
    content.messages.min_by{|message| message.posts_count}
  end

  def next_priority_content
    content = top_priority_content(potential_contents) 
    potential_contents.delete(content)
  end

  def top_priority_content(contents)
    contents.min_by{|content| content.posts_count}
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
