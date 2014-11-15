# encoding: UTF-8
class MessageBufferizer

  def initialize(user)
    @user = user
    @buffered_posts = []
    @potential_contents = user.contents.to_a
  end

  attr_reader :user, :buffered_posts, :potential_contents

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
    # 5 messages
    #
    # Algo : 
    #  1) Select top priority content
    #  2) Add to week (function in homo manner)

    next_content = next_priority_content
    week = BufferWeek.new(Date.today)
    week.schedule(next_content)
  end

  def perform
    # Call preview then save
    # Do the magic
  end

  private

  # Smell : probably needs an iterator object

  def next_priority_content
    content = top_priority_content(potential_contents) 
    potential_contents.delete(content)
  end

  def top_priority_content(contents)
    contents.min_by{|content| content.post_counter}
  end
end

class BufferWeek
  def initialize(first_day)
    # Init days of the week
    @days = [first_day + 1.day]
    (1..4).each {|nb| @days << first_day + nb.days}

    # Init days buffers
    @buffer = []
    (0..4).each {@buffer << []}
  end

  attr_reader :days, :buffer

  def schedule(content)
    @MAX_POST_CONTENT_IN_WEEK = 3
    nb_posts = [@MAX_POST_CONTENT_IN_WEEK, content.messages.count].min
    slots = buffer.find_slots(nb_posts)
    slots.each do |slot|
      buffer[slot] 
    end
  end

  private

  def find_next_slots(nb)
    case nb
      when 1
        return [2]
      when 2
        return [1, 3]
      when 3
        return [0, 2, 4]
      when 4
        return [0, 1, 3, 4]
      when 5
        return 0..4
      when 6
        ????
    end

  end
end
