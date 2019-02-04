class Act < ActiveRecord::Base
  belongs_to :play
  has_many :scenes
  has_many :french_scenes, through: :scenes
  has_many :on_stages, through: :french_scenes
  accepts_nested_attributes_for :scenes, allow_destroy: true

  validates :play, presence: true

  default_scope { order(:act_number) }

  def actors_called(production)
      french_scenes = self.french_scenes
      WhoIsOnStage.new(french_scenes, production).actors_on
  end

  def pretty_name
    "Act #{act_number}"
  end

  def self.play_order(arr)
    arr.sort { |a, b| a.act_number <=> b.act_number}
  end
end
