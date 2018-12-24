class OnStage < ActiveRecord::Base
  belongs_to :character
  belongs_to :french_scene

  validates :french_scene, presence: true
  validates :character, presence: true
end
