class BulkPlayCleaner
  def initialize
    @plays = Play.all
  end

  def run
    @plays.each do |play|
      RemoveBlankFrenchScenes.new(play: play).run
      CorrectFrenchScenesWithoutLines.new(play: play).run
    end
  end
end
