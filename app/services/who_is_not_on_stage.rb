class WhoIsNotOnStage
  attr_accessor :french_scenes, :production, :actors_on_stage, :actors_not_on_stage
  def initialize(french_scenes, production)
    @production = production
    @french_scenes = french_scenes
    @actors_on_stage = []
    @actors_not_on_stage = []
  end

  def run
    actors_on
    remove_duplicate_actors(@actors_on_stage)
    opposite
    remove_duplicate_actors(@actors_not_on_stage)
  end
  def actors_on
    @french_scenes.each do |french_scene|
      french_scene.on_stages.each do |on_stage|
        character = on_stage.character
        job = Job.where(character_id: character.id, production_id: @production.id).includes(:specialization).first
        if job
          @actors_on_stage << job.user
        else
          @actors_on_stage << User.find_by_first_name("Unassigned")
        end
      end
    end
  end
  def remove_duplicate_actors(array)
    array.uniq!
    array.sort! { |a, b| a.name <=> b.name}
  end
  def opposite
    all_users_in_production = @production.involved_users
    all_actors_in_production = []
    all_users_in_production.each do |user|
      user.production_jobs(@production).each do |job|
        if job.specialization.title == "Actor"
          all_actors_in_production << user
        end
      end
    end
    all_actors_in_production.uniq!
    all_actors_in_production.each do |actor|
      unless @actors_on_stage.include?(actor)
        @actors_not_on_stage << actor
      end
    end
    @actors_not_on_stage
  end
end
