class Act < ActiveRecord::Base
  belongs_to :play
  has_many :scenes
  accepts_nested_attributes_for :scenes, allow_destroy: true
  
  validates :play, presence: true
end
