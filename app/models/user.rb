class User < ActiveRecord::Base

  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  ROLES = %i[superadmin regular]

  has_many :characters, through: :jobs
  has_many :conflicts
  has_many :extras
  has_many :invitations, :class_name => self.to_s, :as => :invited_by
  has_many :jobs, dependent: :destroy
  accepts_nested_attributes_for :jobs, reject_if: :all_blank, allow_destroy: true
  has_many :productions, through: :jobs
  has_many :specializations, through: :jobs
  has_many :theaters, through: :jobs

  default_scope { order('first_name') }

  def castings_for_production(production)
    puts self.name
    jobs = production_jobs(production)
    acting_jobs = jobs.select { |job| job.specialization.title == "Actor"}
    puts acting_jobs.size
    return acting_jobs.map(&:character)
  end

  def is_actor?(production)
    unless self.characters.size == 0
      return true
    end
  end

  def name
  	"#{first_name} #{last_name}"
  end
  def name_and_production_job_titles(production)
    "#{name} (#{production_job_titles(production).join(", ")})"
  end
  def production_admin?(production)
    jobs = production_jobs(production)
    admin_jobs = jobs.select { |job| job.specialization.production_admin == true }
    admin_jobs.size > 0 #return true if there are an admin jobs assigned to this user for this production.
  end
  def production_admin_for_play?(play)
    productions = play.productions
    admin = []
    productions.each do |production|
      if production_admin?(production)
        admin << true
      end
    end
    if admin.include?(true)
      return true
    else
      return false
    end
  end
  def production_jobs(production)
    production_jobs = self.jobs.select { |job| job.production_id == production.id }
    return production_jobs
  end
  def production_job_titles(production)
    jobs = production_jobs(production)
    titles = []
    jobs.each do |job|
        titles << job.specialization.title
      end
    return titles
  end
  def regular?
    self.role == "regular"
  end
  def superadmin?
    self.role == "superadmin"
  end
  def theater_admin?(theater)
    jobs = theater_jobs(theater)
    admin_jobs = jobs.select { |job| job.specialization.theater_admin == true }
    admin_jobs.size > 0 #return true if there are admin jobs for this user for this theater.
  end
  def theater_admin_for_play?(play)
    productions = play.productions
    admin = []
    productions.each do |production|
      if theater_admin?(production.theater)
        admin << true
      end
    end
    if admin.include?(true)
      return true
    else
      return false
    end
  end

  def theater_jobs(theater)
    self.jobs.select { |job| job.theater_id == theater.id }
  end



end
