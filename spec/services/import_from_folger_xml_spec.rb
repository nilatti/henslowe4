require 'rails_helper'

describe ImportFromFolgerXml do # all based on the text_xml.xml doc which is the first 2 acts of Richard III from Folger digital texts
  before(:context) do
    create(:author)
  end

  context 'while building play' do
    before(:each) do
      @xml = ImportFromFolgerXml.new('./spec/data/test_xml.xml')
    end
    it 'assigns lines to characters' do
      brakenbury = Character.find_by(xml_id: 'Brakenbury_R3')
      expect(brakenbury.lines.size).to eq(9)
    end

    it 'assigns stage directions to characters' do
      line = Line.find_by(line_number: 'SD 1.1.125.1')
      expect(line.character.name).to eq('William, Lord Hastings')
    end

    it 'builds a dictionary' do
      expect(@xml.dictionary['w0000280'].text).to eq('winter')
    end

    it 'extracts and builds the acts' do
      expect(@xml.play.acts.first.act_number).to eq(1)
      expect(Act.all.size).to eq(2)
      expect(Act.first.play.title).to eq('The Tragedy of Richard III')
    end

    it 'extracts and builds characters' do
      richard = Character.find_by(name: 'Richard')
      citizen = Character.find_by(xml_id: 'CITIZENS.3_R3')
      expect(Character.all.size).to eq(75)
      expect(richard.name).to eq('Richard')
      expect(richard.description).to eq('Duke of Gloucester, later King Richard III')
      expect(richard.gender).to eq('male')
      expect(citizen.name).to be_empty
      expect(citizen.group_id).to eq('CITIZENS_R3')
    end

    it 'extracts and builds french scenes' do
      expect(FrenchScene.all.size).to eq(17)
    end

    it 'extracts and builds lines' do
      expect(Line.where(category: 'text').uniq(&:text).size).to eq(732)
    end

    it 'extracts and builds the play' do
      expect(@xml.play.title).to eq('The Tragedy of Richard III')
      expect(@xml.play.author.last_name).to eq('Shakespeare')
      expect(@xml.play.summary).to include('Richard is Duke of Gloucester and his brother, Edward IV, is king.')
    end

    it 'extracts and builds the scenes' do
      expect(Scene.first.scene_number).to eq(1)
      expect(Scene.all.size).to eq(4)
    end

    it 'generates on-stage information' do
      act = Act.find_by(act_number: 1)
      scene = Scene.find_by(act: act, scene_number: 1)
      french_scene = FrenchScene.find_by(scene: scene, french_scene_number: 'b')
      on_stages = OnStage.where(french_scene: french_scene)
      expect(on_stages.size).to eq(4)
    end

    it 'identifies stage directions' do
      expect(Line.where('category RLIKE ?', '^stage direction').size).to eq(99)
    end

    it 'isolates lines and assigns them to characters' do
      expect(Line.first.character.name).to eq('Richard')
    end
  end

  it 'returns next letter' do
    xml = ImportFromFolgerXml.new('./spec/data/test_xml.xml')
    next_letter = xml.increment_alphabet('c')
    expect(next_letter).to eq('d')
  end
end
