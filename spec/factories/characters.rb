FactoryBot.define do
	factory :character do
		name {Faker::Movies::Lebowski.character}
		play

    factory :richard do
      name 'Richard'
    end
	end
end
