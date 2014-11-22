class TwitterWeekLoadBalancer

  def initialize(week, account)
    # Data
    @week = week
    @account = account

    # Params
    @nb_available_contents = account.contents.count
    @week_load = week.buffered_days.map{|day| 0}
    @nb_days = week_load.size
  end

  attr_reader :week, :account, :nb_available_contents, :week_load, :nb_days

  def perform
    return week_load if nb_available_contents == 0

    step = 2
    first_index = first_index_when_empty
    for i in 0..nb_available_contents-1
      week_load[(first_index + i*step) % nb_days] += 1
    end

    return week_load
  end

  private

  def first_index_when_empty
    case nb_available_contents
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
