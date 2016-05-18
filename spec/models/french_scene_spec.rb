require 'rails_helper'

describe FrenchScene do

    it 'has a valid scene' do
      	expect(build(:french_scene).scene_id).to eq 1
    end

	it 'connects to play' do 
		expect(build(:french_scene).scene.act.play.title).to eq("A Midsummer Night\'s Dream")
	end

	it 'connects to act' do
		expect(build(:french_scene).scene.act.act_number).to eq 1
	end

	it 'returns a pretty name' do
		expect(build(:french_scene).pretty_name).to eq ("1.1.a")
	end
end