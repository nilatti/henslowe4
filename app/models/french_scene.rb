class FrenchScene < ActiveRecord::Base
  belongs_to :scene
  has_many :on_stages, dependent: :destroy
  accepts_nested_attributes_for :on_stages, allow_destroy: true

  has_many :characters, through: :on_stages

  has_many :extras, dependent: :destroy
  accepts_nested_attributes_for :extras, allow_destroy: true

  default_scope { order(:french_scene_number) }

  def pretty_name
    scene.act.act_number.to_s + "." + scene.scene_number.to_s + "." + french_scene_number
  end

  def actors_called(production)
    WhoIsOnStage.new([self], production_id).actors_on
  end
end
