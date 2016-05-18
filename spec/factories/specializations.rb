FactoryGirl.define do
	factory :specialization do
		trait :actor do
      title 'Actor'
      production_admin false
      theater_admin false
    end

    trait :executive_director do
    	title 'Executive Director'
    	theater_admin true
    	production_admin false
    end

    trait :production_manager do
      title 'Production Manager'
      theater_admin false
      production_admin true
    end
	end
end