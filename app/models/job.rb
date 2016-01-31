class Job < ActiveRecord::Base
  belongs_to :user
  belongs_to :specialization
  belongs_to :production
  belongs_to :theater
end
