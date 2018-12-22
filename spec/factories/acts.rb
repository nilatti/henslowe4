FactoryBot.define do
	factory :act do
		sequence :act_number do |n|
			"#{n}"
		end
	 play

		after :create do |act|
			create_list :scene, 2, act: act
		end
	end
end
