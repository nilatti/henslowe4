class FrenchScene < ActiveRecord::Base
  belongs_to :scene
  has_many :on_stages, dependent: :destroy
  accepts_nested_attributes_for :on_stages, allow_destroy: true

  has_many :characters, through: :on_stages

  has_many :extras, dependent: :destroy
  accepts_nested_attributes_for :extras, allow_destroy: true

  has_many :lines, dependent: :destroy
  default_scope { includes(:scene).order('scenes.act_id, scenes.scene_number, french_scene_number') }

  def pretty_name
    format('%01d', scene.act.act_number) + '.' + format('%01d', scene.scene_number) + '.' + french_scene_number
  end

  def actors_called(_production)
    WhoIsOnStage.new([self], production_id).actors_on
  end
end
