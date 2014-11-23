class TwitterWeekLoadBalancer

  MAX_NB_CONTENTS_POSTED_PER_WEEK = 3
  MAX_NB_MESSAGES_POSTED_PER_DAY = 12

  def initialize(week, account)
    # Data
    @week = week
    @account = account

    @week_load = week.buffered_days.map{|day| 0}
  end

  attr_reader :week, :account, :week_load

  def perform
    return week_load if nb_available_messages == 0

    step = 2
    first_index = first_index_when_empty
    for i in 0..nb_available_messages-1
      week_load[(first_index + i*step) % nb_days] += 1
    end

    return week_load
  end

  def nb_available_messages
    @nb_available_messages ||= nb_available_messages_for_the_week(account.contents)
  end

  def contents_messages_count(contents)
    @contents_messages_count ||= contents.joins(:messages).group(:content_id).count("messages.id")
  end

  def nb_messages_postable_in_a_week(content_id, nb_messages = nil)
    nb_messages ||= contents_messages_count(account.contents)[content_id]
    [MAX_NB_CONTENTS_POSTED_PER_WEEK, nb_messages].min
  end

  private

  def nb_days
    week_load.size
  end

  def nb_available_messages_for_the_week(contents)
    total_nb_messages = total_nb_available_messages(contents)
    [MAX_NB_MESSAGES_POSTED_PER_DAY * nb_days, total_nb_messages].min
  end

  def total_nb_available_messages(contents)
    contents_messages_count(contents).sum{|content_id, nb_messages| nb_messages_postable_in_a_week(content_id, nb_messages)}
  end

  def first_index_when_empty
    case nb_available_messages
    when 1
      nb_days/2
    when 2
      nb_days/2 - 1
    when 3
      nb_days/3 - 1
    else
      0
    end
  end

end
