class RemoveFaultyOnStages
  # mostly for noncanonical plays
  attr_accessor :on_stages, :play, :to_destroy

  def initialize(play:)
    @play = play
    @to_destroy = []
  end

  def run
    find_on_stages
    find_faulty_on_stages
    destroy_faulty_on_stages
  end

  def find_faulty_on_stages
    @to_destroy = []

    @on_stages.each do |on_stage|
      if on_stage.french_scene.scene.act.play.id != @play.id
        @to_destroy << on_stage
      else
        puts "#{on_stage.french_scene.scene.act.play.id} matches #{@play.id}"
      end
    end
      # select { |on_stage| on_stage.french_scene.scene.act.play.id != @play.id }
    puts "size to destroy #{@to_destroy} out of #{@on_stages.size}"
  end

  def find_on_stages
    @on_stages = @play.characters.map(&:on_stages)
    @on_stages.flatten!
    puts "found #{@on_stages.size} on_stages"
  end

  def destroy_faulty_on_stages
    @to_destroy.each {|os| os.destroy }
  end
end
