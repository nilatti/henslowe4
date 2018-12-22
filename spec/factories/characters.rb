FactoryBot.define do
	factory :character do
		name {Faker::Movies::Lebowski.character}
		play
	end
end
