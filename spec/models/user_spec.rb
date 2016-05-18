require 'rails_helper'

describe User do

	it 'is valid' do
		expect(build(:user)).to be_valid 
	end

	it 'returns concatenated name' do 
		expect(build(:user).name).to eq("George Washington")
	end

	it 'is superadmin if it has role = superadmin' do
	  user = create(:user, role: "superadmin")
	  expect(user.superadmin?).to be_truthy
  end

  it 'is not a superadmin if role != superadmin' do
    user = create(:user, role: "regular")
    expect(user.superadmin?).to be_falsy
  end
end