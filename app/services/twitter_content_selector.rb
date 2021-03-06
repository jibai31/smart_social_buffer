# encoding: utf-8
class TwitterContentSelector

  def initialize(account, week_load_balancer)
    @account = account
    @week_load_balancer = week_load_balancer

    @buffered_contents = []
    @last_buffered_contents = []
    @buffered_messages = []
  end

  attr_reader :account

  # NB: day argument is not used, but could be later
  #  to select best contents for a given day (eg, quotes on Wednesdays).
  def get_top_contents(day, nb_messages)
    raise_argument_error(nb_messages) if nb_messages > nb_available_messages
    return [] if nb_messages == 0

    top_content_ids = top_contents(nb_messages)
    @last_buffered_contents = top_content_ids.to_a
    @buffered_contents += @last_buffered_contents

    Content.find(top_content_ids)
  end

  private

  # Contents methods

  def nb_available_messages
    @week_load_balancer.nb_available_messages
  end

  def top_contents(nb_contents)
    top_contents = []
    sorted_contents.each do |content_id, posts_count|
      top_contents << pick(content_id) if can_be_picked?(content_id, top_contents)
      break if top_contents.count == nb_contents
    end
 
    # Fill the week with yesterday's contents if nothing else available
    if top_contents.count < nb_contents
      sorted_contents.each do |content_id, posts_count|
        top_contents << pick(content_id) if can_be_picked_at_second_turn?(content_id, top_contents)
        break if top_contents.count == nb_contents
      end
    end

    top_contents
  end

  def sorted_contents
    contents_posts_count.sort_by{|content_id, posts_count| posts_count}
  end

  def contents_posts_count
    @contents_posts_count ||= available_contents.group(:id).sum(:posts_count)
  end

  def available_contents
    account.contents.order(:posts_count).limit(nb_available_messages)
  end

  # Single Content methods

  def pick(content_id)
    contents_posts_count[content_id] += 1
    content_id
  end

  def can_be_picked?(content_id, top_contents)
    !picked_yesterday?(content_id) && !posted_too_many_times?(content_id, top_contents)
  end

  def can_be_picked_at_second_turn?(content_id, top_contents)
    !posted_too_many_times?(content_id, top_contents) && !already_picked?(content_id, top_contents)
  end

  def picked_yesterday?(content_id)
    @last_buffered_contents.include?(content_id)
  end

  def posted_too_many_times?(content_id, top_contents)
    nb_times_posted = @buffered_contents.grep(content_id).size
    nb_times_being_posted = top_contents.grep(content_id).size
    nb_times_postable = @week_load_balancer.nb_messages_postable_in_a_week(content_id)
    nb_times_posted + nb_times_being_posted >= nb_times_postable
  end

  def already_picked?(content_id, top_contents)
    top_contents.grep(content_id).size > 0
  end

  def raise_argument_error(nb_messages)
    raise ArgumentError, "Requested #{nb_messages} messages while only #{nb_available_messages} were available."
  end

end
