class Play < ActiveRecord::Base
  belongs_to :author
  validates :author, presence: true

  has_many :acts
  has_many :scenes, :through => :acts
  has_many :french_scenes, :through => :scenes
  has_many :on_stages, through: :french_scenes

  has_many :characters

  has_many :productions

  accepts_nested_attributes_for :acts, allow_destroy: true
  accepts_nested_attributes_for :scenes, allow_destroy: true
  accepts_nested_attributes_for :french_scenes, allow_destroy: true
  accepts_nested_attributes_for :characters, allow_destroy: true
  accepts_nested_attributes_for :on_stages, allow_destroy: true
end
