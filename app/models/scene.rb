class Scene < ActiveRecord::Base
  belongs_to :act
  has_many :french_scenes, dependent: :destroy
  has_many :characters, through: :french_scenes
  has_many :on_stages, through: :french_scenes

  accepts_nested_attributes_for :french_scenes, allow_destroy: true
  default_scope { order(:scene_number) }

  def pretty_name
    "%01d" % act.act_number + "." + "%01d" % self.scene_number
  end

  def actors_called(production)
      french_scenes = self.french_scenes
      WhoIsOnStage.new(french_scenes, production).actors_on
  end
  def actors_not_called(production_id)
    french_scenes = self.french_scenes
    WhoIsOnStage.new(french_scenes, production_id).actors_off
  end

  def self.play_order(arr)
    items = []
    arr.each do |item|
      act = item.act.act_number.to_i
      scene = item.scene_number.to_i
      item_hash = {
        item: item,
        act: act,
        scene: scene,
      }
      items << item_hash
    end
    sorted = items.sort_by { |a| [a[:act], a[:scene]]}
    returned = sorted.map { |i| i[:item]}
  end
end
