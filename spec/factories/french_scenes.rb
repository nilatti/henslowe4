FactoryBot.define do
	factory :french_scene do
		sequence(:french_scene_number, 'a') {|n| "#{n}"}
		scene

		after :create do |french_scene|
			create_list :line, 3, french_scene: french_scene
		end
	end
end
