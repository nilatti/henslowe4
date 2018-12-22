FactoryBot.define do
	factory :play do

		title 'A Midsummer Night\'s Dream'
		date '1599-01-01'
		author

		after :create do |play|
			create_list :act, 2, play: play
		end
	end
end
