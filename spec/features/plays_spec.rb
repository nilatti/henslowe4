describe "create new play" do
  before do
	  login_as_superadmin
  end

	let(:author) {FactoryGirl.create(:author)}
	let(:play) { FactoryGirl.build(:play, author: author)}

	before(:each) do
		visit new_author_play_path(author)
    expect(page).to have_content 'denied!'
#		fill_in "play_title_input", with: play.title
		#select play.date, :from => "play_date_1i"  Can't figure out how to select this date.
	end

    it "should create play", :pending do 
    	expect { click_button "Create Play" }.to change(Play, :count)
    	expect(page).to have_content 'created'
    end
end
