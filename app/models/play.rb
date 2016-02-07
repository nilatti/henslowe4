class Play < ActiveRecord::Base
  belongs_to :author
  validates :author, presence: true

  has_many :acts, dependent: :destroy
  has_many :scenes, :through => :acts, dependent: :destroy
  has_many :french_scenes, :through => :scenes, dependent: :destroy
  has_many :on_stages, through: :french_scenes, dependent: :destroy

  has_many :characters, dependent: :destroy

  has_many :productions

  default_scope { joins(:author).order("authors.last_name") }
  scope :canonical, -> { where(canonical: true) }

  accepts_nested_attributes_for :acts, allow_destroy: true
  accepts_nested_attributes_for :scenes, allow_destroy: true
  accepts_nested_attributes_for :french_scenes, allow_destroy: true
  accepts_nested_attributes_for :characters, allow_destroy: true
  accepts_nested_attributes_for :on_stages, allow_destroy: true
end
