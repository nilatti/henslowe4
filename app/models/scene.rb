class Scene < ActiveRecord::Base
  belongs_to :act
  has_many :french_scenes

  accepts_nested_attributes_for :french_scenes, allow_destroy: true
  #validates :act, presence: true
  default_scope { order(:scene_number) }

  def pretty_name
  	act.act_number.to_s + "." + scene_number.to_s
  end

  def actors_called(production)
      french_scenes = self.french_scenes
      WhoIsOnStage.new(french_scenes, production).run
  end
end
