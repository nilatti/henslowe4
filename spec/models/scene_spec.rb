require 'rails_helper'

describe Scene do

	it 'connects to play' do 
		expect(build(:scene).act.play.title).to eq("A Midsummer Night\'s Dream")
	end

	it 'connects to act' do
		expect(build(:scene).act.act_number).to eq 1
	end
end