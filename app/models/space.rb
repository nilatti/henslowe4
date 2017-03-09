class Space < ActiveRecord::Base
  has_many :space_agreements, dependent: :destroy
  has_many :theaters, through: :space_agreements
  has_many :conflicts
  has_many :rehearsal_schedules
  has_many :rehearsals
end
