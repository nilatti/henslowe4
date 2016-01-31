require 'rails_helper'

describe Play do


	it 'is valid' do
		expect(build(:play)).to be_valid 
	end

	it 'sets title correctly' do 
		expect(build(:play).title).to eq("A Midsummer Night\'s Dream")
	end
end