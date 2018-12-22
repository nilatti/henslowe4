class BuildDoublingChart
  attr_accessor :table
  def initialize(play:, depth: 'scene')
    @play = play
    @table = ''
    @depth = depth + 's'
  end

  def build_headers
    header_row = []
    header_row << "Character"
    @play.send("#{@depth}".to_sym).each do |item|
      header_row << "#{item.pretty_name}"
    end
    @table << header_row.join(',')
  end

  def build_rows
    @play.characters.each do |character|
      character_row = []
      character_row << character.name
      @play.send("#{@depth}".to_sym).each do |item|
        character_row << write_row(character: character, item: item)
      end
    end
  end

  def line_total(character:, french_scenes:) #array of french scenes
    puts "starting count"
    total_lines = 0
    french_scenes.each do |french_scene|
      puts french_scene.pretty_name
      Line.where(french_scene: french_scene, character: character).each {|l| puts l.text}
      total_lines += Line.where(french_scene: french_scene, character: character).size
    end
    total_lines
  end

  def write_row(character:, item:)

  end

end
