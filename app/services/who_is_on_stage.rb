class WhoIsOnStage
  attr_accessor :actors_on_stage, :appearances, :characters, :french_scenes, :jobs, :production, :appearances, :actors_not_on_stage, :actors
  def initialize(french_scenes, production_id)
    @actors_on_stage = []
    @actors_not_on_stage = []
    @appearances = []
    @characters = []
    @french_scenes = french_scenes
    @jobs = []
    @production = Production.includes(:users).find(production_id)
  end

  def actors_off
    actors_on
    @production.actors.each do |actor, v|
      unless @appearances.has_key?(actor)
        @actors_not_on_stage << actor
      end
    end
    @actors_not_on_stage
  end

  def actors_on
    get_characters
    process_characters
    get_actors
    create_actors_hash
    @appearances
  end

  def create_actors_hash
    actors = @jobs.map {|item| item[:actor]} #array of actor objects
    actors.each do |actor|
      actor_characters = []
      actor_jobs = @jobs.select {|item| item[:actor] == actor } #find jobs where actor is the actor
      actor_jobs.each do |actor_job|
        actor_character = @characters.find {|item| item[:character_id] == actor_job[:character].id}
        actor_characters << actor_character[:report_string]
      end
      actor_object = {
        actor: actor,
        characters: actor_characters,
      }
      @appearances << actor_object
    end
  end

  def get_actors
    @characters.each do |character|
      job = Job.find_by(character_id: character[:character_id], production_id: @production.id)
      if job
        job_hash = {
          actor: job.user,
          character: job.character,
        }
        @jobs << job_hash
      else
        puts "not found"
      end
    end
  end

  def get_characters
    @french_scenes.each do |french_scene|
      french_scene.characters.each do |character|
        puts character.identifier
        report_string = "#{character.identifier}"
        on_stage = OnStage.find_by(french_scene: french_scene, character: character)
        if on_stage.nonspeaking
          report_string << "*"
        end
        character_hash_object = {
          character_id: character.id,
          report_string: report_string,
          french_scene: french_scene,
        }
        @characters << character_hash_object
      end
    end
  end

  def process_characters  # trying to make sure that there is only an * if the character is nonspeaking in ALL french scenes in question
    @characters.each do |item|
      if item[:report_string] =~ /(.*)\*$/
        matches = @characters.select { |character| character[:report_string] =~ /#{$1}$/}
        if matches.size > 0
          @characters.delete(item)
        end
      end
    end
  end
end
