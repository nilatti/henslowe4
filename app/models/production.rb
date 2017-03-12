class Production < ActiveRecord::Base
  belongs_to :play
  belongs_to :theater
  has_many :jobs, dependent: :destroy
  has_many :users, through: :jobs
  accepts_nested_attributes_for :jobs
  has_many :rehearsal_schedules
  has_many :rehearsals, through: :rehearsal_schedules

  accepts_nested_attributes_for :rehearsal_schedules
  validates :start_date, :end_date, presence: true

  def current?
    	self.start_date < Time.now && self.end_date > Time.now
  end
  def future?
    self.start_date > Time.now
  end
  def involved_users
    involved_users = []
    users.each do |user|
      unless user.production_jobs(self).size == 1 && user.production_jobs(self).first.specialization.title == "Auditioner"
        puts "users is not an auditioner"
        involved_users << user
      end
    end

    return involved_users.uniq!
  end
  def past?
   	self.end_date < Time.now
  end
  def pretty_name
  	"#{play.title}, at #{theater.name}, #{start_date} - #{end_date}"
  end
end
