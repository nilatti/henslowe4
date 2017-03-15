class Rehearsal < ActiveRecord::Base
  belongs_to :space
  belongs_to :rehearsal_schedule

  has_many :rehearsal_calls, dependent: :destroy
  has_many :users, through: :rehearsal_calls
  has_many :rehearsal_materials, dependent: :destroy
  accepts_nested_attributes_for :rehearsal_materials
  has_many :plays, through: :rehearsal_materials
  has_many :acts, through: :rehearsal_materials
  has_many :scenes, through: :rehearsal_materials
  has_many :french_scenes, through: :rehearsal_materials

  default_scope { order('start_time')}

  before_create :add_default_users

  def actor_conflicts
    a = FindMaterialThatIsNotRehearsable.new(self.rehearsal_schedule.production, self)
    a.production_actors
    a.get_conflicts
    a.get_actors_who_have_conflicts
    a.conflicts
  end
  def actors_called
    fs_list = give_me_all_french_scenes
    call = WhoIsOnStage.new(fs_list, rehearsal_schedule.production)
    call.run
    call.actors.each do |actor|
      unless users.include?(actor)
        users << actor
      end
    end
  end
  def add_default_users
    unless rehearsal_schedule.default_rehearsal_attendees.empty?
      rehearsal_schedule.default_rehearsal_attendees.each do |dra|
        users << dra.user
      end
    end
  end
  def also_scheduled_today
    month = "%02d" % start_time.month
    day = "%02d" % start_time.day
    today = "#{start_time.year}-#{month}-#{day}%"
    today_rehearsals = Rehearsal.where("rehearsal_schedule_id = ? AND start_time LIKE ?", self.rehearsal_schedule_id, "#{today}").to_a
    today_rehearsals.sort! {|a,b| a.start_time <=> b.start_time}
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
  def give_me_all_french_scenes
    fs_list = []
    unless plays.empty?
      plays.each do |play|
        play.french_scenes.each { |fs| fs_list << fs }
      end
    end
    unless acts.empty?
      acts.each do |act|
        act.french_scenes.each { |fs| fs_list << fs }
      end
    end
    unless scenes.empty?
      scenes.each do |scene|
        scene.french_scenes.each { |fs| fs_list << fs }
      end
    end
    unless french_scenes.empty?
      french_scenes.each { |fs| fs_list << fs }
    end

    fs_list.uniq!
    return fs_list
  end
  def material
    material = []
    unless plays.empty?
      plays.each {|play| material << play }
    end
    unless acts.empty?
      acts.each {|act| material << act }
    end
    unless scenes.empty?
      scenes.each {|scene| material << scene }
    end
    unless french_scenes.empty?
      french_scenes.each {|french_scene| material << french_scene }
    end
    material.uniq!
    return material
  end
  def pages
    material = []
    page_ranges = []
    rehearsal_materials.each do |rm|
      item = ""
      if rm.play
        item = rm.play
      elsif rm.act
        item = rm.act
      elsif rm.scene
        item = rm.scene
      elsif rm.french_scene
        item = rm.french_scene
      end

      material << (item.start_page..item.end_page)
    end
    material.sort! {|a,b| a.first <=> b.first }
    material.each_with_index { |element, index|
      if material[index + 1]
        next_item = material[index + 1]
        if element.overlaps?(next_item)
          puts "#{element} overlaps with #{next_item}"
          material.delete(element)
          material.delete(next_item)

          new_element = (element.first..next_item.last)
          material.unshift(new_element)
        end
      end
    }
    material.sort! {|a,b| a.first <=> b.first }
    if material.size > 1
      material.each_with_index { |element, index|
        if material[index + 1]
          next_item = material[index + 1]
          if element.overlaps?(next_item)
            puts "#{element} overlaps with #{next_item}"
            material.delete(element)
            material.delete(next_item)

            new_element = (element.first..next_item.last)
            material.unshift(new_element)
          end
        end
      }
    end
    material.each do |a|
      if a.first == a.last
        page_ranges << "#{a.first}"
      else
        page_ranges << "#{a.first}-#{a.last}"
      end
    end
    return page_ranges.join(", ")
  end
  def rehearsal_in_today_sequence
    today = also_scheduled_today
    today.index(self)
  end
end
