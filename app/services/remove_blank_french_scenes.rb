class RemoveBlankFrenchScenes
  attr_accessor :blanks, :french_scenes
  def initialize(play:)
    @french_scenes = play.french_scenes
  end
  def run
    find_blanks
    remove_blanks
  end
  def find_blanks
    @blanks = @french_scenes.select { |french_scene| french_scene.on_stages.empty? }
  end
  def remove_blanks
    @blanks.each do |blank|
      puts "destroying #{blank.pretty_name}"
      blank.destroy
    end
  end
end
