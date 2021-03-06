require 'rails_helper'

describe "index of authors", :type => :feature do
	before do
	  login
  end
	it "shows me authors" do
		visit '/authors'
		expect(current_path).to eq(authors_path)
	end
end

describe "create new author" do
	before do
	  login_as_superadmin
  end
	let(:author) { FactoryBot.build(:author)}

	before(:each) do
		visit new_author_path
		fill_in "author_first_name", with: author.first_name
		fill_in "author_last_name", with: author.last_name
		fill_in "author_birth_date", with: author.birth_date
		fill_in "author_death_date", with: author.death_date
		fill_in "author_bio", with: author.bio
	end

    it "should create an author" do 
    	expect { click_button "Create Author" }.to change(Author, :count)
    	expect(page).to have_content 'created'
    end
end
