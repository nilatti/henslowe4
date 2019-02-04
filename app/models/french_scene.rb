class FrenchScene < ActiveRecord::Base
  belongs_to :scene
  has_many :on_stages, dependent: :destroy
  accepts_nested_attributes_for :on_stages, allow_destroy: true

  has_many :characters, through: :on_stages

  has_many :extras, dependent: :destroy
  accepts_nested_attributes_for :extras, allow_destroy: true

  has_many :lines, dependent: :destroy
  # default_scope { includes(:scene).order('scenes.act_id, scenes.scene_number, french_scene_number') }

  def actors_called(production)
    WhoIsOnStage.new([self], production.id).actors_on
  end

  def pretty_name
    format('%01d', scene.act.act_number) + '.' + format('%01d', scene.scene_number) + '.' + french_scene_number
  end

  def self.play_order(arr)
    items = []
    arr.each do |item|
      act = item.scene.act.act_number.to_i
      scene = item.scene.scene_number.to_i
      french_scene = item.french_scene_number.to_s
      item_hash = {
        item: item,
        act: act,
        scene: scene,
        french_scene: french_scene
      }
      items << item_hash
    end
    sorted = items.sort_by { |a| [a[:act], a[:scene], a[:french_scene].length, a[:french_scene]]}
    returned = sorted.map { |i| i[:item]}
  end
end
