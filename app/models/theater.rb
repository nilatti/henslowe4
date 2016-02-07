class Theater < ActiveRecord::Base
	has_many :space_agreements, dependent: :destroy
	has_many :spaces, through: :space_agreements
	has_many :productions
	has_many :plays, through: :productions
	has_many :jobs
	has_many :users, through: :jobs
end
