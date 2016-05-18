FactoryGirl.define do
	factory :user do

		first_name 'George'
		last_name 'Washington'
		email 'test1@test.com'
		password 'password'
		encrypted_password User.new.send(:password_digest, :password)
		role 'regular'

	end
end