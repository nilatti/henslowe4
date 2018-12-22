FactoryBot.define do
	factory :scene do
		sequence :scene_number do |n|
			"#{n}"
		end
		act

		after :create do |scene|
			create_list :french_scene, 4, scene: scene
		end
	end
end
