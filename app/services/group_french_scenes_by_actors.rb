class GroupFrenchScenesByActors
  attr_accessor :french_scenes, :french_scenes_to_sort, :production, :all_actors, :overlapping_groups
  def initialize(french_scenes, production)
    @french_scenes = Hash.new {|h,k| h[k]=[]}
    @production = production
    @french_scenes_to_sort = french_scenes.to_a
    @overlapping_groups = Hash.new {|h,k| h[k]=[]}
  end

  def all_actors
    @all_actors = []
    @french_scenes_to_sort.each do |french_scene|
      @all_actors << french_scene.actors_called(@production)
    end
    @all_actors.uniq!
  end

  def find_recommendations
    if @all_actors
      all_actors = @all_actors.to_set
      all_french_scenes = @production.french_scenes
      all_french_scenes.each do |french_scene|
        french_scene_actors = french_scene.actors_called(@production).to_set
        if french_scene_actors == all_actors
          @overlapping_groups[all_actors.size] << french_scene
        else
          overlap = french_scene_actors & all_actors
          @overlapping_groups[overlap.size] << french_scene
        end
      end
    end
    return @overlapping_groups
  end

  def find_fs_with_same_actors
    @french_scenes_to_sort.each do |french_scene|
      actor_group = french_scene.actors_called(@production)
      @french_scenes[actor_group] << french_scene
    end
  end

  def put_french_scene_groups
    @french_scenes.each do |key, value|
      puts "#{key.map(&:name).join(", ")}\t #{value.map(&:pretty_name).join(", ")}"
    end
  end

  def french_scenes_sort_by_closeness_to_given_fs(french_scene)
    on_stage = french_scene.actors_called(@production)
    closeness = Hash.new {|h,k| h[k]=[]}
    @french_scenes_to_sort.each do |compare|
      overlap = on_stage & compare.actors_called(@production)
      closeness[overlap.size] << compare
    end
    return closeness
  end
end
