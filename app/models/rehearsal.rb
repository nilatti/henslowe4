class Rehearsal < ActiveRecord::Base
  belongs_to :act
  belongs_to :scene
  belongs_to :french_scene
  belongs_to :space
  belongs_to :production
end
