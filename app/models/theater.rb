class Theater < ActiveRecord::Base
	has_many :space_agreements, dependent: :destroy
	has_many :spaces, through: :space_agreements
	has_many :productions
	has_many :plays, through: :productions
	has_many :jobs
	has_many :users, through: :jobs

	def castable_users
		self.involved_users.size
	end

	def involved_users
    involved_users = []
    users.each do |user|
			acting_jobs = user.theater_jobs(self).select { |job| job.specialization_id == 1 || job.specialization_id == 2 }
			puts acting_jobs.size
      if acting_jobs.size > 0
				involved_users << user
			end
    end
		return involved_users.uniq{|t| t.id }
  end
end
