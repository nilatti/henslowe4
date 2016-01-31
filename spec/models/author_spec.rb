require 'rails_helper'

describe Author do

	it 'is invalid if birth date is after death date' do
		expect(build(:author, birth_date: "2015-01-01")).to be_invalid
	end
    
    subject { create(:author) }

	describe '#name' do
      it 'returns a well-formatted string' do
        expect(subject.name).to eq('William Shakespeare')
      end
    end
end