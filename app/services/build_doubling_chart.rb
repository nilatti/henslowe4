class BuildDoublingChart
  attr_accessor :acts, :french_scenes, :header_row, :scenes, :table
  def initialize(play:, depth: 'scene')
    @play = play
    @table = []
    @depth = depth
    @delimiter = "\t"
    build_chart
  end

  def build_chart
    build_headers
    build_rows
    sort_table
    write_file
  end

  def build_headers
    header_row = []
    header_row << "Character"
    items = []
    if @depth == 'french_scene'
      @french_scenes = FrenchScene.play_order(@play.french_scenes)
      items = @french_scenes
    elsif @depth == 'scene'
      @scenes = Scene.play_order(@play.scenes)
      items = @scenes
    elsif @depth == 'act'
      @acts = Act.play_order(@play.acts)
      items = @acts
    end
    items.each do |item|
      header_row << "#{item.pretty_name}"
    end
    @header_row = header_row.join(@delimiter) + "\n"
  end

  def build_rows
    @play.characters.each do |character|
      if @depth == 'french_scene'
        printable_row = build_row_french_scene(character: character)
      elsif @depth == 'scene'
        printable_row = build_row_scene(character: character)
      elsif @depth == 'act'
        printable_row = build_row_act(character: character)
      else
        puts 'failed'
      end
      @table << printable_row
    end
    @table
  end

  def build_row_act(character:)
    character_row = []
    character_row << generate_name(character)
    @acts.each do |act|
      if act.on_stages.select {|on_stage| on_stage.character == character}.size > 0
        character_lines = line_total(character: character, french_scenes: [act.french_scenes])
        if character_lines > 1
          character_row << character_lines
        else
          character_row << '(X)'
        end
      else
        character_row << ''
      end
    end
    printable_row = character_row.join(@delimiter) + "\n"
  end

  def build_row_french_scene(character:)
    character_row = []
    character_row << generate_name(character)
    @french_scenes.each do |french_scene|
      if french_scene.on_stages.select {|on_stage| on_stage.character == character}.size > 0
        character_lines = line_total(character: character, french_scenes: [french_scene])
        if character_lines > 1
          character_row << character_lines
        else
          character_row << '(X)'
        end
      else
        character_row << ''
      end
    end
    printable_row = character_row.join(@delimiter) + "\n"
  end

  def build_row_scene(character:)
    character_row = []
    character_row << generate_name(character)
    @scenes.each do |scene|
      if scene.on_stages.select {|on_stage| on_stage.character == character}.size > 0
        character_lines = line_total(character: character, french_scenes: [scene.french_scenes])
        if character_lines > 1
          character_row << character_lines
        else
          character_row << '(X)'
        end
      else
        character_row << ''
      end
    end
    printable_row = character_row.join(@delimiter) + "\n"
  end

  def generate_name(character)
    if !character.name.empty?
      return "#{character.name}"
    else
      return "#{character.xml_id}"
    end
  end

  def line_total(character:, french_scenes:) #array of french scenes
    total_lines = 0.0
    french_scenes.each do |french_scene|
      lines = Line.where(french_scene: french_scene, character: character)
      spoken_lines = lines.reject{|line| line.line_number.match?(/^SD/)}
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

  def name(character:)
    if !character.name.empty?
      character.name
    else
      character.xml_id
    end
  end

  def sort_table
    @table = @table.sort
    @table.prepend @header_row
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
