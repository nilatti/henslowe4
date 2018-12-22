class Act < ActiveRecord::Base
  belongs_to :play
  has_many :scenes
  has_many :french_scenes, through: :scenes
  accepts_nested_attributes_for :scenes, allow_destroy: true
  has_many :french_scenes, through: :scenes

  validates :play, presence: true

  default_scope { order(:act_number) }

  def actors_called(production)
      french_scenes = self.french_scenes
      WhoIsOnStage.new(french_scenes, production).run
  end

  def pretty_name
    "Act #{act_number}"
  end
end
