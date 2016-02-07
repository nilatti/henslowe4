class Space < ActiveRecord::Base
  has_many :space_agreements, dependent: :destroy
  has_many :theaters, through: :space_agreements
  
end
