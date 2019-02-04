class BulkGrid
  def initialize
    @plays = Play.all
  end

  def run
    @plays.each do |play|
      BuildDoublingChart.new(play: play, depth: 'french_scene')
      BuildDoublingChart.new(play: play, depth: 'scene')
      BuildDoublingChart.new(play: play, depth: 'act')
    end
  end
end
