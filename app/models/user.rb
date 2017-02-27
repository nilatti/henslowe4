class User < ActiveRecord::Base

  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  ROLES = %i[superadmin regular]


  has_many :jobs, dependent: :destroy
  accepts_nested_attributes_for :jobs, reject_if: :all_blank, allow_destroy: true
  has_many :specializations, through: :jobs
  has_many :productions, through: :jobs
  has_many :theaters, through: :jobs

  has_many :invitations, :class_name => self.to_s, :as => :invited_by

  def superadmin?
  	self.role == "superadmin"
  end

  def regular?
    self.role == "regular"
  end

  def production_jobs(production)
    self.jobs.select { |job| job.production_id == production.id }
  end

  def theater_jobs(theater)
    self.jobs.select { |job| job.theater_id = theater.id }
  end

  def production_admin?(production)
    jobs = production_jobs(production)
    admin_jobs = jobs.select { |job| job.specialization.production_admin == true }
    admin_jobs.size > 0 #return true if there are an admin jobs assigned to this user for this production.
  end

  def theater_jobs(theater)
    self.jobs.select { |job| job.theater_id == theater.id }
  end

  def theater_admin?(theater)
    jobs = theater_jobs(theater)
    admin_jobs = jobs.select { |job| job.specialization.theater_admin == true }
    admin_jobs.size > 0 #return true if there are admin jobs for this user for this theater.
  end

  def name
  	"#{first_name} #{last_name}"
  end

  def castings_for_production(production)
    FindDoublingProblems.new(self, production).characters
  end
end
