class Production < ActiveRecord::Base
  belongs_to :play
  belongs_to :theater
  has_many :jobs, dependent: :destroy
  has_many :users, through: :jobs
  accepts_nested_attributes_for :jobs

  def pretty_name
  	"#{play.title}, at #{theater.name}, #{start_date} - #{end_date}"
  end
 
end
