class RehearsalMaterial < ActiveRecord::Base
  belongs_to :rehearsal
  belongs_to :play
  belongs_to :act
  belongs_to :scene
  belongs_to :french_scene
end
