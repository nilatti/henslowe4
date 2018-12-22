class Character < ActiveRecord::Base
  belongs_to :play
  has_many :on_stages
  has_many :french_scenes, through: :on_stages, dependent: :destroy
  has_many :jobs, dependent: :destroy
  has_many :lines, dependent: :destroy

  default_scope { order('name') }

  def nonspeaking?(french_scene)
    on_stage = OnStage.find_by(character: self, french_scene: french_scene)
    on_stage.nonspeaking
  end
end
