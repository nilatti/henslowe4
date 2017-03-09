class BuildRehearsalSchedule
  attr_accessor :rehearsal_schedule, :rehearsal_times, :rehearsal_dates, :weekdays

  def initialize(rehearsal_schedule)
    @rehearsal_schedule = rehearsal_schedule
    @rehearsal_times = []
    @rehearsal_dates = []
    @weekdays = []
  end

  def run
    get_dates
    set_rehearsal_times
    make_and_save_rehearsals
  end

  def get_dates
    @rehearsal_schedule.start_date.upto(@rehearsal_schedule.end_date) do |date|
      if @rehearsal_schedule.rehearsal_days.include?(date.wday)
        @rehearsal_dates << date
      end
    end
  end

  def set_rehearsal_times
    @rehearsal_dates.each do |date|
      current_time = DateTime.parse("#{date.year}-#{date.month}-#{date.day} #{@rehearsal_schedule.start_time.hour}:#{@rehearsal_schedule.start_time.min}:00")
      end_time = DateTime.parse("#{date.year}-#{date.month}-#{date.day} #{@rehearsal_schedule.end_time.hour}:#{@rehearsal_schedule.start_time.min}:00")
      until current_time == end_time
        @rehearsal_times << current_time
        current_time = current_time + @rehearsal_schedule.interval.to_i.minutes
      end
    end
  end

  def make_and_save_rehearsals
    @rehearsal_times.each do |rehearsal_time|
      new_rehearsal = Rehearsal.new
      new_rehearsal.space = @rehearsal_schedule.space
      new_rehearsal.start_time = rehearsal_time
      new_rehearsal.end_time = rehearsal_time + @rehearsal_schedule.interval.to_i.minutes
      new_rehearsal.rehearsal_schedule = @rehearsal_schedule
      new_rehearsal.save
    end
  end
end
