FactoryGirl.define do
	factory :play do

		title 'A Midsummer Night\'s Dream'
		date '1599-01-01'
		association :author
	end
end