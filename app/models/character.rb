class Character < ActiveRecord::Base
  belongs_to :play
  belongs_to :character_group
  has_many :on_stages, dependent: :destroy
  has_many :french_scenes, through: :on_stages, dependent: :destroy
  has_many :jobs, dependent: :destroy
  has_many :lines, dependent: :destroy

  default_scope { order('name') }

  def identifier
    if !name.blank?
      name
    elsif !xml_id.blank?
      xml_id
    else
      "nameless"
    end
  end

  def line_count
    total_lines = 0.0
    french_scenes.each do |french_scene|
      lines = Line.where(french_scene: french_scene, character: self)
      spoken_lines = lines.reject{|line| line.line_number.match?(/^SD/) || line.cut}
      spoken_lines.each do |line|
        if line.ana == 'short'
          puts 'short line'
          total_lines += 0.5
        else
          total_lines += 1
        end
      end
    end
    total_lines.round
  end

  def nonspeaking?(french_scene)
    on_stage = OnStage.find_by(character: self, french_scene: french_scene)
    on_stage.nonspeaking
  end
end
