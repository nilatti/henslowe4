class WhoIsOnStage
  attr_accessor :french_scenes, :production, :appearances, :actors_not_on_stage, :actors
  def initialize(french_scenes, production_id)
    @production = Production.includes(:users).find(production_id)
    @french_scenes = french_scenes
    @appearances = Hash.new { |hash, key| hash[key] = Array.new}
    @actors_not_on_stage = []
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
    @french_scenes.each do |french_scene|
      french_scene.on_stages.each do |on_stage|
        character = on_stage.character
        report_string = "#{on_stage.character.name}"
        if on_stage.nonspeaking
          report_string = "#{report_string}*"
        end
        job = Job.where(character_id: character.id, production_id: @production.id).first
        if job.user
          if report_string.match?(/\*$/)
            remove_asterisk = report_string.chomp('*')
            if @appearances[job.user].index { |i| i.match?(/#{Regexp.quote(remove_asterisk)}(?<!\*)$/) }
            else
              @appearances[job.user].push report_string
            end
          else
              @appearances[job.user].push report_string
          end
        else
          @appearances[User.find_by_first_name("Unassigned")] << report_string
        end
      end
      french_scene.extras.each do |extra|
        @appearances[extra.user] << extra.name
      end
    end
    @appearances.each { |k, v| v.uniq! }
    @appearances = @appearances.sort_by { |k, v| k.name }.to_h
    return @appearances
  end
end
