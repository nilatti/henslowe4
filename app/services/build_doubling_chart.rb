class BuildDoublingChart
  attr_accessor :table
  def initialize(play:, depth: 'scene')
    @play = play
    @table = []
    @depth = depth + 's'
    @delimiter = "\t"
    build_chart
  end

  def build_chart
    build_headers
    build_rows
    write_file
  end

  def build_headers
    header_row = []
    header_row << "Character"
    @play.send("#{@depth}".to_sym).each do |item|
      header_row << "#{item.pretty_name}"
    end
    printable_row = header_row.join(@delimiter) + "\n"
    @table << printable_row
  end

  def build_rows
    @play.characters.each do |character|
      character_row = []
      character_row << name(character: character)
      @play.send("#{@depth}".to_sym).each do |item|
        character_lines = 0
        french_scenes = get_french_scenes_for_item(item: item)
        character_lines = line_total(character: character, french_scenes: french_scenes)
        if character_lines > 1
          character_row << character_lines
        else
          french_scenes.each do |french_scene|
            if !OnStage.where({character: character, french_scene: french_scene}).empty?
              character_row << "(0)"
            else
              character_row << ''
            end
          end
        end
      end
      printable_row = character_row.join(@delimiter) + "\n"
      @table << printable_row
    end
    @table
  end

  def get_french_scenes_for_item(item:)
    if item.is_a? FrenchScene
      return [item]
    elsif item.is_a? Scene || item.is_a? Act
      return [item.french_scenes]
    else
      puts "failed"
    end
  end

  def line_total(character:, french_scenes:) #array of french scenes
    total_lines = 0
    french_scenes.each do |french_scene|
      lines = Line.where(french_scene: french_scene, character: character)
      spoken_lines = lines.reject{|line| line.line_number.match?(/^SD/)}
      total_lines += spoken_lines.size
    end
    total_lines
  end

  def name(character:)
    if !character.name.empty?
      character.name
    else
      character.xml_id
    end
  end

  def write_file
    output = "external_data/#{@play.title}-#{@depth}-chart.tsv"
    File.open(output, 'w') do |file|
      @table.each do |row|
        file.print row
      end
    end
  end
end
