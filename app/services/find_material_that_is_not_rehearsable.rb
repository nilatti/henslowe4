class FindMaterialThatIsNotRehearsable
  attr_accessor :production, :rehearsal, :actors, :conflicts, :unavailable_actors, :unavailable_french_scenes, :available_french_scenes, :unavailable_scenes, :available_scenes, :unavailable_acts, :available_acts, :whole_play, :unavailable_french_scenes_array
  def initialize(production, rehearsal)
    @production = production
    @rehearsal = rehearsal
    @actors = []

    @conflicts = []

    @unavailable_actors = []
    @unavailable_french_scenes = {}
    @unavailable_french_scenes_array = []
    @available_french_scenes =[]
    @unavailable_scenes = {}
    @available_scenes = []
    @unavailable_acts = {}
    @available_acts = []
    @whole_play = false
  end

  def run
    production_actors
    @actors.uniq!
    @actors.reject! {|a| a.nil? }

    get_conflicts
    get_actors_who_have_conflicts
    get_french_scenes_unavailable
    get_scenes_unavailable
    get_acts_unavailable
    full_run?
    @unavailable_french_scenes.sort_by { |key, value | key }
    @unavailable_scenes.sort_by { |key, value | key }
    @unavailable_acts.sort_by {|key, value| key }
    @available_french_scenes.sort! { |a, b| a.actors_called(production).size <=> b.actors_called(production).size }
    @available_scenes.sort! { |a, b| a.actors_called(production).size <=> b.actors_called(production).size }
    @available_acts.sort! { |a, b| a.actors_called(production).size <=> b.actors_called(production).size }
  end

  def production_actors
    @production.jobs.each do |job|
      if job.acting?
        @actors << job.user
      end
    end
  end

  def get_conflicts
    @actors.each do |actor|
      actor.conflicts.each do |conflict|
        if during_rehearsal?(conflict)  
          @conflicts << conflict
        end
      end
    end
  end

  def get_actors_who_have_conflicts
    @conflicts.each do |conflict|
      @unavailable_actors << conflict.user
    end
  end

  def get_french_scenes_unavailable
    @production.play.french_scenes.each do |french_scene|
      overlap = french_scene.actors_called(@production) & @unavailable_actors
      if overlap.size > 0
        @unavailable_french_scenes["#{french_scene.pretty_name}"] = overlap
        @unavailable_french_scenes_array << french_scene
      else
        @available_french_scenes << french_scene
      end
    end
  end

  def get_scenes_unavailable
    @production.play.scenes.each do |scene|
      overlap = scene.french_scenes & @unavailable_french_scenes_array
      if overlap.size > 0
        unavailable_actors = scene.actors_called(@production) & @unavailable_actors
        @unavailable_scenes["#{scene.pretty_name}"] = unavailable_actors
      else
        @available_scenes << scene
      end
    end
  end

  def get_acts_unavailable
    @production.play.acts.each do |act|
      overlap = act.french_scenes & @unavailable_french_scenes_array
      if overlap.size > 0
        unavailable_actors = act.actors_called(@production) & @unavailable_actors
        @unavailable_acts["#{act.act_number}"] = unavailable_actors
      else
        @available_acts << act
      end
    end
  end

  def full_run?
    overlap = @production.play.french_scenes & @unavailable_french_scenes_array
    if overlap.size > 0
      @whole_play = false
    else
      @whole_play = true
    end
  end

  def during_rehearsal?(conflict)
    if conflict.start_time <= rehearsal.end_time && rehearsal.start_time <= conflict.end_time
      return true
    else
      return false
    end
  end

end
