class RehearsalMaterial < ActiveRecord::Base
  belongs_to :rehearsal
  belongs_to :play
  belongs_to :act
  belongs_to :scene
  belongs_to :french_scene

  after_save :update_people_called_for_rehearsal

  def update_people_called_for_rehearsal
    rehearsal.actors_called
  end

end
