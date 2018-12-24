require 'faker'

FactoryBot.define do
	factory :line do
		text {Faker::Games::Myst.quote}
    french_scene
    character

    factory :lines_for_richard do
      association :character, factory: :richard
    end
	end
end
