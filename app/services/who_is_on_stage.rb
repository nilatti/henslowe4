class WhoIsOnStage
  attr_accessor :french_scenes, :production, :appearances
  def initialize(french_scenes, production)
    @production = production
    @french_scenes = french_scenes
    @appearances = {}
  end

  def run
    actors_on
    return @appearances
  end
  def actors_on
    @french_scenes.each do |french_scene|
      french_scene.on_stages.each do |on_stage|
        character = on_stage.character

        report_string = "#{on_stage.character.name}"
        if on_stage.nonspeaking
          report_string = "#{report_string}*"
        end
        job = Job.where(character_id: character.id, production_id: @production.id).first
        if job
          if @appearances.has_key?(job.user)
            if @appearances[job.user].match(/\*/)
              @appearances[job.user] = report_string
            else
            end
          else
            @appearances[job.user] = report_string
          end
        else
          @appearances[User.find_by_first_name("Unassigned")] << report_string
        end
      end
    end
  end
end
