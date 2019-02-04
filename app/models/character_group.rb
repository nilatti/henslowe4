class CharacterGroup < ActiveRecord::Base
  belongs_to :play
  has_many :characters
end
