describe "create new play" do
	let(:author) {FactoryGirl.create(:author)}
	let(:play) { FactoryGirl.build(:play, author: author)}

	before(:each) do
		visit new_author_play_path(author)
		fill_in "play_title", with: play.title
		#select play.date, :from => "play_date_1i"  Can't figure out how to select this date.
	end

    it "should create play" do 
    	expect { click_button "Create Play" }.to change(Play, :count)
    	expect(page).to have_content 'created'
    end
end
