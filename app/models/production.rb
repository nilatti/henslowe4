class Production < ActiveRecord::Base
  belongs_to :play
  belongs_to :theater
  has_many :jobs
  has_many :users, through: :jobs
 
end
