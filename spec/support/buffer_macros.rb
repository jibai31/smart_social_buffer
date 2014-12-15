# To use such a macro, the spec needs to do the following:
#
# require 'service_under_test'
#  OR
# require 'rails_helper'
#
# require 'support/buffer_macros'
# RSpec.configure{|c| c.include BufferMacros}
#
module BufferMacros

  # Helper methods

  def posts_count(week)
    week.buffered_days.inject(0) {|sum, day| sum + day.buffered_posts.size}
  end

  def same_day(buffered_post)
    day = buffered_post.buffered_day.day
    buffered_post.run_at.strftime('%Y-%m-%d') == day.strftime('%Y-%m-%d')
  end

  def test_today
    Date.new(2014,12,14)
  end

  def build_test_week
    BufferedWeekFactory.new(account.planning, Date.new(2014,12,15)).build
  end

  def create_test_week
    week = build_test_week
    week.save
    week
  end

  # RSpec Matchers

  RSpec::Matchers.define :run_around do |expected_time|
    match do |buffered_post|
      day = buffered_post.buffered_day.day
      posting_time = buffered_post.run_at

      same_day = same_day(buffered_post)

      not_before_time = (posting_time + 20.minutes).hour == expected_time
      not_after_time  = (posting_time - 20.minutes).hour == (expected_time - 1)

      same_day && not_before_time && not_after_time
    end

    failure_message do |buffered_post|
      day = buffered_post.buffered_day.day
      posting_time = buffered_post.run_at
      if same_day(buffered_post)
        "It expected around #{expected_time}H but got #{posting_time.to_s(:time)}"
      else
        "It expected on #{day.strftime('%Y-%m-%d')} but got #{posting_time.strftime('%Y-%m-%d')}"
      end
    end

    failure_message_when_negated do |buffered_post|
      "It expected posting time not to be around #{expected_time}"
    end

  end
end
