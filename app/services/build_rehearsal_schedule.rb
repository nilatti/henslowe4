class BuildRehearsalSchedule
  attr_accessor :rehearsal_schedule, :rehearsal_times, :rehearsal_dates, :weekdays

  def initialize(rehearsal_schedule)
    @rehearsal_schedule = rehearsal_schedule
    @rehearsal_times = []
    @rehearsal_dates = []
    @weekdays = []
  end

  def run
    get_weekdays
    get_dates
    set_rehearsal_times
    make_and_save_rehearsals
  end

  def get_weekdays
    @rehearsal_schedule.rehearsal_days.each do |day|
      puts day
      day.downcase!
      if day == "sunday"
        @weekdays << 0
      elsif day == "monday"
        @weekdays << 1
      elsif day == "tuesday"
        @weekdays << 2
      elsif day == "wednesday"
        @weekdays << 3
      elsif day == "thursday"
        @weekdays << 4
      elsif day == "friday"
        @weekdays << 5
      elsif day == "saturday"
        @weekdays << 6
      end
    end
  end

  def get_dates
    puts "weekdays: #{@weekdays}"
    puts "rehearsal schedule: #{@rehearsal_schedule.updated_at}"
    puts "rehearsal schedule class #{@rehearsal_schedule.class}"
    puts "start date: #{@rehearsal_schedule.start_date}"
    puts "end date: #{@rehearsal_schedule.end_date}"
    @rehearsal_schedule.start_date.upto(@rehearsal_schedule.end_date).each do |date|
      puts "date: #{date}"
      puts "weekday: #{date.wday}"
      puts "#{date.wday.class}"
      if @weekdays.include?(date.wday)
        @rehearsal_dates << date
      end
    end
    puts "rehearsal dates: #{@rehearsal_dates}"
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
    puts "rehearsal times #{@rehearsal_times}"
  end

  def make_and_save_rehearsals
    @rehearsal_times.each do |rehearsal_time|
      new_rehearsal = Rehearsal.new
      new_rehearsal.space = @rehearsal_schedule.space
      new_rehearsal.start_time = rehearsal_time
      new_rehearsal.end_time = rehearsal_time + @rehearsal_schedule.interval.to_i.minutes
      new_rehearsal.rehearsal_schedule = @rehearsal_schedule
      @rehearsal_schedule.default_rehearsal_attendees.each { |dra| new_rehearsal.users << dra.user }
      new_rehearsal.save
      puts "new rehearsal id #{new_rehearsal.id}"
    end
  end
end
