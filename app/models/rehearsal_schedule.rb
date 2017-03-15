class RehearsalSchedule < ActiveRecord::Base
  belongs_to :production
  belongs_to :space
  has_many :rehearsals, dependent: :destroy
  has_many :default_rehearsal_attendees, dependent: :destroy
  has_many :users, through: :default_rehearsal_attendees

  def rehearsal_days
    rehearsal_days = []
    if monday
      rehearsal_days << "Monday"
    end
    if tuesday
      rehearsal_days << "Tuesday"
    end
    if wednesday
      rehearsal_days << "Wednesday"
    end
    if thursday
      rehearsal_days << "Thursday"
    end
    if friday
      rehearsal_days << "Friday"
    end
    if saturday
      rehearsal_days << "Saturday"
    end
    if sunday
      rehearsal_days << "Sunday"
    end
    return rehearsal_days
  end

  def dailies
    dailies = Hash.new {|h,k| h[k] = [] }
    rehearsals.each do |rehearsal|
      date = Date.parse("#{rehearsal.start_time.year}-#{rehearsal.start_time.month}-#{rehearsal.start_time.day}")
      if rehearsal.space
        space = rehearsal.space.name
      else
        space = "TBA"
      end
      dailies["#{date.strftime("%A, %b %-d")} at #{space}"] << rehearsal
    end
    return dailies
  end
end
