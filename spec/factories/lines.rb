require 'faker'

FactoryBot.define do
	factory :line do
		text {Faker::Games::Myst.quote}
	end
end
