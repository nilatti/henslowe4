FactoryBot.define do
	factory :production do

		association :play
		association :theater

		start_date Time.now
		end_date Time.now + 3.months
	end
end