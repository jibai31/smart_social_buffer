# encoding: UTF-8
class WeekPlanner

  def initialize(account, week, args = {})
    # Data
    @account = account
    @week = week

    # Services
    @week_load_balancer = args[:week_load_balancer] || WeekLoadBalancerFactory.new(account).build(week)
    @message_selector = args[:message_selector] || MessageSelectorFactory.new(account).build
    @day_planner = args[:day_planner] || DayPlannerFactory.new(account).build(@message_selector)
    @content_selector = args[:content_selector] || ContentSelectorFactory.new(account).build(@week_load_balancer)

    # Init
    @nb_contents_per_day = week_load_balancer.perform
  end

  # attr_reader :user, :buffered_posts, :potential_contents, :week
  attr_reader :account, :week, :week_load_balancer, :day_planner, :content_selector, :nb_contents_per_day

  def preview
    # TWITTER ONLY : target_post_frequency = 1 message per hour 
    #
    #  - a content can only be posted once in a day      [x]  Content selector
    #  - a content can only be posted 3 times in a week  [x]  Week load balancer
    #  - avoid posting a content 2 days in a row         [x]  Content selector
    #  - only posts between 8AM and 8PM (simplification) [x]  Day planner
    #  - a message can only be posted once in a week     [x]  Message selector
    #  - less than 1 msg/h = 12 msg/day = 84 msg/week    [x]  Week load balancer
    #
    #  - homogeneous distribution on a week              [x]  Week load balancer
    #  - homegeneous distribution in a day               [x]  Day planner
    #

    week.buffered_days.each_with_index do |day, day_position|
      day_capacity = nb_contents_per_day[day_position]
      top_contents = content_selector.get_top_contents(day, day_capacity)

      day_planner.perform(day, top_contents)
    end

  end

  def perform
    preview
    week.save
  end

  # For tests only
  def print
    week.buffered_days.each_with_index do |day, i|
      puts "Day #{i}: #{day.day} -> #{day.buffered_posts.count} contents buffered for that day" 
      day.buffered_posts.each do |post|
        puts "  #{post.run_at}: #{post.message.text.truncate(15)}"
      end
    end
  end

end
