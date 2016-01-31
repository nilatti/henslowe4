module Timely
  extend ActiveSupport::Concern

private
  def end_after_start
    return if end_time.blank? || start_time.blank?
 
    if end_time < start_time
      errors.add(:end_time, "must be after the start date") 
    end 
   end

 def during_event
  
    unless self.start_time.between?(self.event.start_time, self.event.end_time) 
 		errors.add(:start_time, "It looks like this doesn't take place during your event. Please check your time.")
 	end

 	unless self.end_time.between?(self.event.start_time, self.event.end_time) 
 		errors.add(:end_time, "It looks like this doesn't take place during your event. Please check your time.")
 	end
 end
end