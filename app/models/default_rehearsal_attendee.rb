class DefaultRehearsalAttendee < ActiveRecord::Base
  belongs_to :rehearsal_schedule
  belongs_to :user
end
