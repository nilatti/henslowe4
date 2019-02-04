class AddOnStagesBasedOnLines
  attr_accessor :lines, :needed_on_stages, :on_stages
  def initialize(play)
    @lines = play.lines
    @on_stages = play.on_stages
    @needed_on_stages = []
  end

  def run
    analyze_lines
    create_on_stages
  end

  def analyze_lines
    @lines.each do |line|
      matching = @on_stages.find {|on_stage| on_stage.french_scene == line.french_scene && on_stage.character == line.character }
      if !matching
        @needed_on_stages << OnStage.new(french_scene: line.french_scene, character: line.character, nonspeaking: false)
      end
    end
  end

  def create_on_stages
    OnStage.import @needed_on_stages
  end
end
