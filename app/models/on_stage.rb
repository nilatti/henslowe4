class OnStage < ActiveRecord::Base
  belongs_to :character
  belongs_to :french_scene
  # default_scope { joins(:character).order("characters.name") }
end
