class Planning < ActiveRecord::Base
  belongs_to :account

  # Weeks
  has_many :buffered_weeks, dependent: :destroy
  after_create :initialize_coming_weeks

  # Instance methods

  def current_week
    buffered_weeks.find_by_first_day(beginning_of_current_week)
  end

  def next_week
    buffered_weeks.find_by_first_day(beginning_of_next_week)
  end

  def coming_weeks(first_day = nil)
    first_day ||= beginning_of_current_week
    buffered_weeks.where("first_day >= ?", first_day)
  end

  def initialize_coming_weeks
    first_day = beginning_of_current_week
    weeks = coming_weeks(first_day).to_a
    while weeks.size < 3
      monday = first_day + (weeks.size).weeks
      factory = BufferedWeekFactory.new(self, monday)
      factory.create
      weeks << factory.week
    end
  end

  private

  def beginning_of_current_week
    Date.today.beginning_of_week
  end

  def beginning_of_next_week
    (Date.today + 1.week).beginning_of_week
  end
end
