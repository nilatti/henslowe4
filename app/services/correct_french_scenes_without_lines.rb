class CorrectFrenchScenesWithoutLines
  attr_accessor :adjusted_scenes, :need_fixed, :play

  def initialize(play:)
    @adjusted_scenes = []
    @need_fixed = []
    @play = play
    @french_scenes = FrenchScene.play_order(@play.french_scenes)
  end

  def run
    find_french_scenes_that_need_fixed
    move_stage_directions_to_previous_french_scene
    renumber_french_scenes
  end

  def find_french_scenes_that_need_fixed
    @french_scenes.each do |french_scene|
      speaking = french_scene.on_stages.select {|on_stage| on_stage.nonspeaking == false}
      if speaking.size == 0
        @need_fixed << french_scene
      end
    end
    puts "french scenes eneding fixed #{@need_fixed.size}"
  end

  def move_stage_directions_to_previous_french_scene
    @need_fixed.each do |french_scene|
      @adjusted_scenes << french_scene.scene
      french_scene_index = @french_scenes.index(french_scene)
      next if french_scene_index == 0
      next_french_scene = @french_scenes[french_scene_index - 1]
      french_scene.lines.each do |line|
        line.french_scene = next_french_scene
        line.save
      end
      french_scene.destroy
    end
  end

  def renumber_french_scenes
    @adjusted_scenes.uniq!
    @adjusted_scenes.each do |scene|
      french_scene_number = 'a'
      french_scenes = FrenchScene.play_order(scene.french_scenes)
      french_scenes.each do |french_scene|
        french_scene.french_scene_number = french_scene_number
        french_scene.save
        french_scene_number = french_scene_number.next
      end
    end
  end
end
