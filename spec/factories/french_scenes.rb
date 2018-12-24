FactoryBot.define do
	factory :french_scene do
		sequence(:french_scene_number, 'a') {|n| "#{n}"}
		scene
	end
end
