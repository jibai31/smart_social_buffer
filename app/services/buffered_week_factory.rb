class BufferedWeekFactory

  def initialize(planning, first_day = nil)
    @planning = planning
    @first_day = first_day || beginning_of_current_week
  end

  attr_reader :week

  def build
    @week = planning.buffered_weeks.build(first_day: first_day)
    for i in 0..6
      @week.buffered_days.build(day: first_day + i.days)
    end
    @week
  end

  def create
    build.save
  end

  def create!
    build.save!
  end

  private

  attr_reader :planning, :first_day

  def beginning_of_current_week
    Date.today.beginning_of_week
  end
end
