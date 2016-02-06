class FrenchScene < ActiveRecord::Base
  belongs_to :scene
  has_many :on_stages

  has_many :characters, through: :on_stages, dependent: :destroy

  default_scope { order(:french_scene_number) }
 
  def pretty_name
  	
    scene.act.act_number.to_s + "." + scene.scene_number.to_s + "." + french_scene_number
  end
end
