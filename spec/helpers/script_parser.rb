require 'rails_helper'

describe ParseScript do
  
  it "calls correctly" do 
  	string = self.make_thing
  	expect(string).to eq("This is my test string")
  end

  it "finds the script" do
  	play = create(:play)
  	puts play.script
  end
end