class FrenchScene < ActiveRecord::Base
  belongs_to :scene

 
  def pretty_name
  	
    scene.act.act_number.to_s + "." + scene.scene_number.to_s + "." + french_scene_number
  end
end
