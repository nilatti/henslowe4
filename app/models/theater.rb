class Theater < ActiveRecord::Base
	has_many :spaces
	has_many :productions
	has_many :plays, through: :productions
	has_many :jobs
	has_many :users, through: :jobs
end
