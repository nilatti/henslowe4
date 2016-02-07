class Job < ActiveRecord::Base
  belongs_to :user
  belongs_to :specialization
  belongs_to :production
  belongs_to :theater
  belongs_to :character

  scope :acting, -> { where(specialization_id: 2)}
  
  def acting?
  	specialization_id == 2 || specialization_id == 5
  end
  
end
