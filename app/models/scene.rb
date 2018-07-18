class Scene < ActiveRecord::Base
  belongs_to :act
  has_many :french_scenes, dependent: :destroy

  accepts_nested_attributes_for :french_scenes, allow_destroy: true
  #validates :act, presence: true
  default_scope { order(:scene_number) }

  def pretty_name
  	act.act_number.to_s + "." + scene_number.to_s
  end

  def actors_called(production)
      french_scenes = self.french_scenes
      WhoIsOnStage.new(french_scenes, production).actors_on
  end
  def actors_not_called(production_id)
    french_scenes = self.french_scenes
    WhoIsOnStage.new(french_scenes, production_id).actors_off
  end
end
