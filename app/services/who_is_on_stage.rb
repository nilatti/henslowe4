class WhoIsOnStage
  attr_accessor :french_scenes, :production, :actors
  def initialize(french_scenes, production)
    @production = production
    @french_scenes = french_scenes
    @actors = []
    actors_on
    Rails.logger.info "number of actors on stage is #{@actors.size}"
  end

  def actors_on
    @french_scenes.each do |french_scene|
      french_scene.on_stages.each do |on_stage|
        character = on_stage.character
        job = Job.where(character_id: character.id, production_id: @production.id).first
        @actors << job.user
      end
    end
  end
end
