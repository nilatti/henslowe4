class Character < ActiveRecord::Base
  belongs_to :play
  has_many :on_stages
  has_many :french_scenes, through: :on_stages, dependent: :destroy

end
