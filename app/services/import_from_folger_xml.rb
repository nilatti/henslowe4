class ImportFromFolgerXml
  attr_accessor :acts,
  :characters,
  :character_groups,
  :current_act,
  :current_french_scene,
  :current_characters_on_stage,
  :current_scene,
  :dictionary,
  :french_scenes,
  :lines,
  :on_stages,
  :parsed_xml,
  :play,
  :scenes,
  :text_file

  def initialize(text_file)
    xml_doc = File.read(text_file) # for Folger Digital Texts, must remove the TEI tags at beginning and end
    @acts = []
    @characters = []
    @character_groups = []
    @french_scenes = []
    @lines = []
    @on_stages = []
    @scenes = []
    @current_characters_on_stage = []
    @dictionary = {}
    @parsed_xml = Nokogiri::XML.parse(xml_doc)

  end

  def run
    build_dictionary
    create_play
    commit_lines
    review_on_stages
    # remove_blank_lines
    # RemoveBlankFrenchScenes.new(@play).run
  end

  def add_value_to_dictionary(value)
    key = value.attr('xml:id')
    @dictionary[key] = value
  end

  def build_acts
    puts "building acts"
    @parsed_xml.xpath('//div1').each do |act|
      act_number = act.attr('n')
      @current_act = Act.create(act_number: act_number, play: @play)
      act.xpath('div2').each do |scene|
        build_scenes(act: @current_act, scene: scene)
      end
    end
  end

  def build_characters
    puts "building characters"
    @parsed_xml.xpath('//person').each do |person|
      gender = person.xpath('sex').text
      remove_white_spaces(gender)
      description = person.xpath('state').text
      remove_white_spaces(description)
      if person.attr('corresp')
        puts "this person has corresp attribute and it is #{person.attr('corresp')}"
        search_key = person.attr('corresp').delete('#')
        group = @character_groups.find {|group| group.xml_id == search_key}
      end
      xml_id = person.attr('xml:id')
      name = person.xpath('persName').text
      if name.blank?
        name = xml_id || person.attr('corresp').sub(/#/, '')
      end
      remove_white_spaces(name)
      @characters << Character.new(name: name, description: description, gender: gender, character_group: group, xml_id: xml_id, play: @play)
    end
    Character.import @characters, :on_duplicate_key_ignore
    @characters = Character.where(play: @play)
  end

  def build_character_groups
    character_groups = []
    @parsed_xml.xpath('//personGrp').each do |group|
      xml_id = "#{group.attr('xml:id')}"
      name = group.xpath('name').text
      if name.blank?
        name = group.xpath('persName').text
      end
      if name.blank?
        name = group.attr('xml:id') || name = 'Missing Character'
      end
      corresp = group.attr('corresp')
      remove_white_spaces(name)
      character_group = CharacterGroup.new(corresp: corresp, name: name, play: @play, xml_id: xml_id, )
      character_groups << character_group
    end
    CharacterGroup.import character_groups
    @character_groups = CharacterGroup.where(play: @play)
  end

  def build_characters_from_character_groups
    @character_groups.each do |group|
      if group.characters.size == 0
        Character.create(name: group.xml_id, xml_id: xml_id, play: @play)
      end
    end
  end

  def build_dictionary
    # puts "building dictionary"
    @parsed_xml.xpath('//w').each do |value|
      add_value_to_dictionary(value)
    end
    @parsed_xml.xpath('//pc').each do |value|
      add_value_to_dictionary(value)
    end
    @parsed_xml.xpath('//c').each do |value|
      add_value_to_dictionary(value)
    end
  end

  def build_line(milestone, next_milestone = nil)
    # puts "building lines"
    milestone_line = []
    line_pieces = milestone.attr('corresp').split(/ /)
    next_line = []
    if next_milestone && next_milestone.attr('rend') == 'turnunder'
      puts "found next line"
      next_line_pieces = next_milestone.attr('corresp').split(/ /)
      next_line_pieces.each do |id|
        id.sub!(/#/, '')
        if @dictionary[id]
          next_line << @dictionary[id].text
        else
          next_line << ''
        end
      end
      next_line[0] = " #{next_line[0]}"
    end
    line_pieces.each do |id|
      id.sub!(/#/, '')
      if @dictionary[id]
        milestone_line << @dictionary[id].text
      else
        milestone_line << ''
      end
    end
    completed_line = milestone_line.flatten.join
    completed_line += next_line.join
    completed_line = remove_white_spaces(completed_line)
  end

  def build_scenes(act:, scene:)
    @current_characters_on_stage = []
    scene_number = scene.attr('n')
    @current_scene = Scene.create(scene_number: scene_number, act: act)
    @current_french_scene_number = 'a'
    @on_last_french_scene = false
    scene_xml_nodes = scene.children
    scene_xml_nodes.pop
    scene_xml_nodes.each do |child|
      if child == scene_xml_nodes.last
        @on_last_french_scene = true
      end
      if child.matches?('stage')
        if child.attr('type') == 'mixed'
          unmix_stage_direction(stage: child)
        elsif child.attr('xml:id')
          process_stage_direction(stage: child)
        else
          # puts 'no xml id found'
        end
      elsif child.matches?('sp')
        process_speech(speech: child, character: child.attr('who'))
      end
    end
  end

  def commit_lines
    Line.import @lines
    @lines = []
    OnStage.import @on_stages
    @on_stages = []
  end

  def create_play
    # puts "building play"
    # puts @parsed_xml.xpath('//addrLine').size
    author = Author.find_by(last_name: 'Shakespeare')
    canonical = true
    summary = @parsed_xml.xpath('//text//front//div[@type="synopsis"]').text
    text_notes = 'This text is derived from the Folger Digital Text Editions'
    title = @parsed_xml.xpath('//title').first.text
    @play = Play.create(author: author, canonical: canonical, summary: summary, text_notes: text_notes, title: title)
    build_character_groups
    build_characters
    build_acts
  end

  def find_characters(line:)
    # puts "finding character"
    characters = []
    xml_id = line.attr('who').delete('#') if line.attr('who')
    # puts "xml id ix #{xml_id}"
    characters = xml_id.split(' ') if xml_id
  end

  def increment_alphabet(letter)
    letter.next!
  end

  def organize_text(text:) # expects Nokogiri element that has children that contain text.
    # puts "organizing text"
    words = text.children
    textual_array = words.map(&:text)
    text_string = textual_array.join
    remove_white_spaces(text_string)
  end

  def process_speech(character:, speech:) # #line: Nokogiri node object, character: xml_id string
    if character
      characters = [character.delete('#')] || find_characters(speech)
    else
      character = Character.create(name: 'missing character')
      characters = [character]
    end
    speech.children.each do |child|
      if child.matches?('ab')
        process_line(characters: characters, speech: child)
      end
    end
  end

  def process_line(characters:, speech:)
    speech.children.each do |child|
      puts child.attr('n')
      if child.matches?('stage')
        process_stage_direction(stage: child, characters: characters)
      elsif child.matches?('milestone')
        next if child.attr('rend') == 'turnunder'
        next unless child.attr('xml:id') && child.attr('corresp')
        next_milestone = speech.xpath('milestone')[speech.xpath('milestone').index(child) + 1]
        process_milestones_in_a_speech(characters: characters, milestone: child, next_milestone: next_milestone)
      elsif child.matches?('seg')
        puts child
        puts child.children.size
        child.children.each do |seg_child|
          puts "in a seg child"
          puts
          if seg_child.attr('unit') == 'ftln'
            next_index = child.children.index(seg_child)
            if next_index
              next_milestone = child.children[next_index + 1]
            end
            puts seg_child
            process_milestones_in_a_speech(characters: characters, milestone: seg_child, next_milestone: next_milestone)
          end
        end
      end
    end
  end

  def process_milestones_in_a_speech(characters:, milestone:, next_milestone: nil)
    text = build_line(milestone, next_milestone)#, next_milestone)
    characters.each do |character_xml_id|
      character = @characters.find {|character| character.xml_id == character_xml_id }
      unless character
        character = Character.new(name: 'Missing Character')
        @characters << character
      end
      new_line = Line.new(
        ana: milestone.attr('ana'),
        category: 'text',
        character: character,
        french_scene: @current_french_scene,
        line_number: milestone.attr('n') || '',
        text: text
      )
      @lines << new_line
    end
  end

  def process_stage_direction(stage:, characters: nil) # stage: Nokogiri node object, characters: array of xml_id strings
    text = organize_text(text: stage)
    characters = if stage.attr('type') == 'delivery'
      characters
    else
      find_characters(line: stage)
    end
    if characters
      if stage.attr('type') == 'entrance' || stage.attr('type') == 'exit'
        unless @on_last_french_scene
          @current_french_scene = FrenchScene.create(french_scene_number: @current_french_scene_number, scene: @current_scene)
        end
        @current_french_scene_number = increment_alphabet(@current_french_scene.french_scene_number)
      end
      characters.each do |character_xml_id|
        if !character_xml_id.is_a? String

        end
        character = @characters.find {|character| character.xml_id == character_xml_id }
        if character
          new_line = Line.new(
            category: "stage direction: #{stage.attr('type')}",
            character: character,
            french_scene: @current_french_scene,
            line_number: stage.attr('n') || '',
            text: text
          )
          @lines << new_line
          if stage.attr('type') == 'entrance'
            @current_characters_on_stage << character
            group = @character_groups.find { |group| group.xml_id == character_xml_id }
            if group
              group.characters.each {|character| @current_characters_on_stage << character }
            end
          end
          if stage.attr('type') == 'exit'
            @current_characters_on_stage.reject! {|character| character.xml_id == character_xml_id}
            group = @character_groups.find { |group| group.xml_id == character_xml_id }
            if group
              group.characters.each {|group_character| @current_characters_on_stage.reject! {|group_character| group_character.xml_id == character_xml_id}}
            end
          end
        end
      end
    end
    if stage.attr('type') == 'entrance' || stage.attr('type') == 'exit'
      @current_characters_on_stage.uniq.each do |character_on_stage|
        @on_stages << OnStage.new(french_scene: @current_french_scene, character: character_on_stage)
      end
    end
  end

  def remove_blank_lines
    @lines.each do |line|
      if line.text.empty?
        line.destroy
      end
    end
  end

  def remove_white_spaces(line)
    line.gsub!(/\s+\./, '.')
    line.gsub!(/\s+\,/, ',')
    line.gsub!(/\s+/, ' ')
    line.gsub!(/^\s/, '')
    line.gsub!(/\s+$/, '')
    line.gsub!(/(\r\n|\r|\n)/, '')
    line.delete!("\n")
    line.delete!("\r")
    line
  end

  def review_on_stages
    @play.french_scenes.each do |french_scene|
      french_scene.on_stages.each do |on_stage|
        speaking = french_scene.lines.select {|line| line.character == on_stage.character && (!line.category.match(/^stage/) || !line.line_number.match(/^SD/))}
        if speaking.size > 0
          on_stage.nonspeaking = false
          on_stage.save!
        else
          on_stage.nonspeaking = true
          on_stage.save!
        end
      end
    end
  end

  def unmix_stage_direction(stage:)
    stage.children.each do |stage_direction|
      next unless stage_direction.attr('xml:id') && stage_direction.attr('xml:id').match?(/^stg/)

      process_stage_direction(stage: stage_direction)
    end
  end
end
