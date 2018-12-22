require 'rails_helper'

describe BuildDoublingChart do # all based on the text_xml.xml doc which is the first 2 acts of Richard III from Folger digital texts
  before(:context) do
    @play = create(:play)
  end
  context 'initial setup' do

    it 'generates correct headers for act depth' do
      chart = BuildDoublingChart.new(play: @play, depth: 'act')
      chart.build_headers
      expect(chart.table).to match(/Character,Act \d,Act \d/)
    end

    it 'generates correct headers for french scene depth (implied)' do
      chart = BuildDoublingChart.new(play: @play, depth: 'french_scene')
      chart.build_headers
      expect(chart.table).to eq("Character,1.1.a,1.1.b,1.1.c,1.1.d,1.1.e,1.2.a,1.2.b,1.2.c,1.2.d,2.1.a,2.1.b,2.1.c,2.1.d,2.2.a,2.2.b,2.2.c,2.2.d")
    end

    it 'generates correct headers for scene depth (explicit)' do
      chart = BuildDoublingChart.new(play: @play, depth: 'scene')
      chart.build_headers
      expect(chart.table).to eq("Character,1.1,1.2,2.1,2.2")
    end
    it 'generates correct headers for scene depth (implied)' do
      chart = BuildDoublingChart.new(play: @play)
      chart.build_headers
      expect(chart.table).to eq("Character,1.1,1.2,2.1,2.2")
    end
    it 'gets total lines per character for french scene' do
      chart = BuildDoublingChart.new(play: @play)
      puts "chart"
      character = Character.find_by(name: 'Richard')
      puts "#{character.name}"
      act = Act.find_by(act_number: 1)
      scene = Scene.find_by(act: act, scene_number: 1)
      french_scene = FrenchScene.find_by(scene: scene, french_scene_number: 'b')
      puts "starting the count in test"
      french_scenes = [french_scene]
      total_lines = chart.line_total(character: character, french_scenes: french_scenes)
      expect(total_lines).to eq(43)
    end
  end
end
