FactoryBot.define do
	factory :job do
		association :specialization
		association :theater
		association :production
		association :user
	end
end