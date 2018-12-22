class Line < ActiveRecord::Base
  belongs_to :french_scene
  belongs_to :character
end
