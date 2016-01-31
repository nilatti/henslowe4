class Author < ActiveRecord::Base
  include Timely
  validate :death_after_birth
  has_many :plays

  def name
  	first_name + " " + last_name
  end

private
  def death_after_birth
    return if death_date.blank? || birth_date.blank?
 
    if death_date < birth_date
      errors.add(:death_date, "A person has to be born before they die.") 
    end 
   end

  
end
