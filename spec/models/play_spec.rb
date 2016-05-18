require 'rails_helper'

describe Play do


	it 'is valid' do
		expect(build(:play)).to be_valid 
	end

	it 'sets title correctly' do 
		expect(build(:play).title).to eq("A Midsummer Night\'s Dream")
	end

	it 'sets production id to = production on duplication' do 
	end

	it 'finds its production' do
		prod = create(:production)
		play = create(:play)
		play.production_id = prod.id
    expect(play.production).to eq(prod)
	end
end