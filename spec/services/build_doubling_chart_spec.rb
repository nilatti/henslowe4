require 'rails_helper'

describe BuildDoublingChart do # all based on the text_xml.xml doc which is the first 2 acts of Richard III from Folger digital texts
  before(:context) do
    @play = create(:play)
    @richard = create(:richard, play: @play)
    @scene = @play.scenes.first
     @scene.french_scenes.each do |french_scene|
      create_list(:line, 5, french_scene: french_scene, character: @richard)
      create_list(:line, 8, french_scene: french_scene)
    end

  end
  context 'initial setup' do

    it 'gets total lines per character for french scene' do
      chart = BuildDoublingChart.new(play: @play)
      french_scenes = [@scene.french_scenes.first]
      total_lines = chart.line_total(character: @richard, french_scenes: french_scenes)
      expect(total_lines).to eq(5)
    end

    it 'gets total lines per character for scene' do
      chart = BuildDoublingChart.new(play: @play)
      french_scenes = @scene.french_scenes
      total_lines = chart.line_total(character: @richard, french_scenes: french_scenes)
      expect(total_lines).to eq(20)
    end

    it 'gets total lines per character for scene' do
      chart = BuildDoublingChart.new(play: @play)
      other_scene = @play.scenes[1]
      other_scene.french_scenes.each do |french_scene|
       create_list(:line, 5, french_scene: french_scene, character: @richard)
       create_list(:line, 8, french_scene: french_scene)
      end
      act = @play.acts.first
      french_scenes = []
      act.scenes.each { |scene| french_scenes << scene.french_scenes}
      french_scenes.flatten!
      total_lines = chart.line_total(character: @richard, french_scenes: french_scenes)
      expect(total_lines).to eq(40)
    end

    it 'returns correct french scene arrays' do
      other_character = Character.find(2)
      another_character = Character.find(3)
      @scene = @play.scenes.first
       @scene.french_scenes.each do |french_scene|
        create_list(:line, 5, french_scene: french_scene, character: other_character)
        create_list(:line, 8, french_scene: french_scene, character: another_character)
      end
      chart = BuildDoublingChart.new(play: @play, depth: 'french_scene')
      rows = chart.build_rows
      expect(rows).to include('Richard,5,5,5,5,,,,,,,,,,,,,,,,,,,,,,,,')
    end

    it 'returns correct scene arrays' do
      other_character = Character.find(2)
      another_character = Character.find(3)
      @scene = @play.scenes.first
       @scene.french_scenes.each do |french_scene|
        create_list(:line, 5, french_scene: french_scene, character: other_character)
        create_list(:line, 8, french_scene: french_scene, character: another_character)
      end
      chart = BuildDoublingChart.new(play: @play, depth: 'scene')
      rows = chart.build_rows
      expect(rows).to include('Richard,20,,,,,,')
    end

    it 'returns correct act arrays' do
      other_character = Character.find(2)
      another_character = Character.find(3)
      @scene = @play.scenes.first
       @scene.french_scenes.each do |french_scene|
        create_list(:line, 5, french_scene: french_scene, character: other_character)
        create_list(:line, 8, french_scene: french_scene, character: another_character)
      end
      chart = BuildDoublingChart.new(play: @play, depth: 'act')
      rows = chart.build_rows
      expect(rows).to include('Richard,20,,')
    end
  end
end
