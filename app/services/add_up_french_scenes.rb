class AddUpFrenchScenes
  attr_accessor :french_scenes, :acts, :scenes, :whole_play
  def initialize(french_scenes)
    @french_scenes = french_scenes.to_set
    @whole_play = false
    @acts = []
    @scenes = []
  end

  def run
    extract_whole_play
    extract_acts
    extract_scenes
  end

  def extract_whole_play
    play = @french_scenes.first.scene.act.play
    play_french_scenes = play.french_scenes.to_set
    if play_french_scenes.subset? @french_scenes
      @whole_play = true

      @french_scenes.subtract(play_french_scenes)
    end
  end

  def extract_acts
    @french_scenes.each do |french_scene|
      act = french_scene.scene.act
      act_french_scenes = act.french_scenes.to_set
      if act_french_scenes.subset? @french_scenes
        @acts << act
        @french_scenes.subtract(act_french_scenes)
      end
    end
  end
  def extract_scenes
    @french_scenes.each do |french_scene|
      scene = french_scene.scene
      scene_french_scenes = scene.french_scenes.to_set
      if scene_french_scenes.subset? @french_scenes
        @scenes << scene
        @french_scenes.subtract(scene_french_scenes)
      end
    end
  end

end
