class Rehearsal < ActiveRecord::Base
  attr_accessor :french_scene_group, :scenes, :acts, :plays
  belongs_to :space
  belongs_to :rehearsal_schedule

  has_many :french_scenes_rehearsals, dependent: :destroy

  has_many :french_scenes, through: :french_scenes_rehearsals

  default_scope { order('start_time')}

  before_save :serialize_french_scenes

  def material
    unless self.french_scenes.empty?
      m = AddUpFrenchScenes.new(self.french_scenes)
      m.run
      material = []
      if m.whole_play
        material << rehearsal_schedule.production.play.title
      end
      m.acts.each do |act|
        material << act.pretty_name
      end
      m.scenes.each do |scene|
        material << scene.pretty_name
      end
      m.french_scenes.each do |french_scene|
        material << french_scene.pretty_name
      end
      return material.to_a
    else
      return []
    end
  end

  def actors_called
    call = WhoIsOnStage.new(french_scenes, rehearsal_schedule.production)
    call.run
    actors = call.actors
  end

  def also_scheduled_today
    month = "%02d" % start_time.month
    day = "%02d" % start_time.day
    today = "#{start_time.year}-#{month}-#{day}%"
    today_rehearsals = Rehearsal.where("rehearsal_schedule_id = ? AND start_time LIKE ?", self.rehearsal_schedule_id, "#{today}").to_a
    today_rehearsals.sort! {|a,b| a.start_time <=> b.start_time}
  end

  def pages
    page_ranges = []
    puts "french scenes #{french_scenes.size}"
    unless self.french_scenes.empty?
      french_scenes = french_scenes.to_a
      if french_scenes.size > 0
        french_scenes.sort! { |a, b| a.pretty_name <=> b.pretty_name }
        first = french_scenes.shift
        current_start_page = first.start_page
        current_end_page = first.end_page
        french_scenes.each do |french_scene|
          if french_scene.end_page == current_start_page
            current_end_page = french_scene.end_page
          else
            current_end_page = french_scene.end_page
            page_ranges << "#{current_start_page}-current_end_page"
          end
        end

        # french_scene = french_scenes.shift
        # current_start_page = french_scene.start_page
        # current_end_page = french_scene.end_page
        #
        # french_scene = french_scenes.shift
        #   puts "current_end: #{current_end_page}\t french_scene pages #{french_scene.start_page}-#{french_scene.end_page}"
        #   if french_scene.start_page == current_end_page
        #     current_end_page = french_scene.end_page
        #   else
        #     current_end_page = french_scene.end_page
        #     page_ranges << "#{current_start_page}-#{current_end_page}"
        #   end
        page_ranges.sort!
      end
    end
    return page_ranges
  end

  def serialize_french_scenes
    french_scene_serializer = []
    unless plays.blank?
      play = Play.find(plays.first)
      play.french_scenes.each {|fs| french_scene_serializer << fs }
    end
    if acts
      acts.each do |act|
        unless act.blank?
          act = Act.find(act)
          act.french_scenes.each {|fs| french_scene_serializer << fs }
        end
      end
    end
    if scenes
      scenes.each do |scene|
        unless scene.blank?
          scene = Scene.find(scene)
          scene.french_scenes.each {|fs| french_scene_serializer << fs }
        end
      end
    end
    if french_scene_group
      french_scene_group.each do |fs|
        unless fs.blank?
          french_scene = FrenchScene.find(fs)
          french_scene_serializer << french_scene
        end
      end
    end
    french_scene_serializer.uniq!
    french_scene_serializer.each {|fs| self.french_scenes << fs }
  end

  def rehearsal_in_today_sequence
    today = also_scheduled_today
    today.index(self)
  end

  def find_previous_rehearsal
    rehearsal_index = rehearsal_in_today_sequence
    previous_index = rehearsal_index - 1
    if previous_index >= 0
      previous_rehearsal = also_scheduled_today[previous_index]
    end
  end

  def find_next_rehearsal
    rehearsal_index = rehearsal_in_today_sequence
    next_index = rehearsal_index + 1
    if next_index <= also_scheduled_today.size
      next_rehearsal = also_scheduled_today[next_index]
    end
  end

  def generate_previous_recommendation
    previous_rehearsal = find_previous_rehearsal
    if previous_rehearsal
      GroupFrenchScenesByActors.new(previous_rehearsal.french_scenes, rehearsal_schedule.production).find_recommendations
    end
  end

  def generate_next_recommendation
    next_rehearsal = find_next_rehearsal
    if next_rehearsal
      GroupFrenchScenesByActors.new(next_rehearsal.french_scenes, rehearsal_schedule.production).find_recommendations
    end
  end

end
