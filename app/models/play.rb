class Play < ActiveRecord::Base

  belongs_to :author

  has_many :acts, dependent: :destroy
  has_many :scenes, :through => :acts, dependent: :destroy
  has_many :french_scenes, :through => :scenes, dependent: :destroy
  has_many :on_stages, through: :french_scenes, dependent: :destroy
  has_many :characters, dependent: :destroy
  has_many :productions

  #has_attached_file :script

  validates :author, presence: true

  #validates_attachment_content_type :script, content_type: {content_type: ["text/plain", "text/html"]}, allow_blank: true

  #before_save :parse_script

  default_scope { joins(:author).order("authors.last_name") }
  scope :canonical, -> { where(canonical: true) }

  accepts_nested_attributes_for :acts, allow_destroy: true
  accepts_nested_attributes_for :scenes, allow_destroy: true
  accepts_nested_attributes_for :french_scenes, allow_destroy: true
  accepts_nested_attributes_for :characters, allow_destroy: true
  accepts_nested_attributes_for :on_stages, allow_destroy: true

  def canonical?
    self.canonical
  end

  def production
    unless self.production_id.nil?
      Production.find(production_id)
    end
  end

  def pretty_name
    title
  end
  def parse_script
    io = StringIO.new(Paperclip.io_adapters.for(self.script).read, 'r')

  end
end
