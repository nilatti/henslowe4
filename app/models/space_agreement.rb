class SpaceAgreement < ActiveRecord::Base
  belongs_to :theater
  belongs_to :space
end
