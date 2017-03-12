class Job < ActiveRecord::Base
  belongs_to :user
  belongs_to :specialization
  belongs_to :production
  belongs_to :theater
  belongs_to :character

  # before_create :remove_audition_job

  scope :acting, -> { where(specialization_id: 2)}

  def acting?
  	specialization_id == 2 || specialization_id == 1 #acting is 2, auditioner is 1
  end

  # def remove_audition_job
  #   if specialization_id == 2 #is it an acting job that is being assigned
  #     audition_job = Job.find_by(user: user_id, production: production_id, specialization: 1)
  #     audition_job.destroy
  #   end
  # end
end
