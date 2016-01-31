require 'rails_helper'

describe Act do

	it 'connects to play' do 
		expect(build(:act).play.title).to eq("A Midsummer Night\'s Dream")
	end
end