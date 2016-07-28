require "rails_helper"

describe "with logged in user" do 
	def log_in_as(user)
  	visit new_user_session_path
  	fill_in("user_email", with: user.email)
  	fill_in("user_password", with: user.password)
    click_button("Log in")
  end

  let(:user) { User.create(email: "test@example.com", password: "password", role: "regular") }
  let(:superuser) { User.create(email: "super@example.com", password: "password", role: "superadmin") }
  let(:user_2) { User.create(email: "stooge@example.com", password: "password", role: "regular")}
  let(:canonical_play) { FactoryGirl.create(:play, :canonical => true) }
  let(:theater) { FactoryGirl.create(:theater) }
  let(:noncanonical_play) { FactoryGirl.create(:play, :canonical => false) }
  let(:production) { FactoryGirl.create(:production, :theater => theater, :play => noncanonical_play) }
    

#manage play

  it "allows superuser to edit canonical play" do
    log_in_as(superuser)
    visit edit_play_path(canonical_play)
    expect(current_path).to eq(edit_play_path(canonical_play))
  end

  it "does not allow regular user to edit canonical play" do
   
    log_in_as(user)
    visit(edit_play_path(canonical_play))
    expect(current_path).to eq("/")
  end	

  it "allows theater manager to edit non-canonical play" do
    prod = create(:production, :theater => theater, :play => noncanonical_play)
    play = create(:play, :canonical => false, :production_id => prod.id)
    specialization = create(:specialization, :executive_director)
    Job.create(user: user, specialization: specialization, theater: theater)
    log_in_as(user)
    visit(edit_play_path(play))
    expect(current_path).to eq(edit_play_path(play))
  end

  it "allows production manager to edit non-canonical play" do
    prod = create(:production, :theater => theater, :play => noncanonical_play)
    play = create(:play, :canonical => false, :production_id => prod.id)
    specialization = create(:specialization, :production_manager)
    user = create(:user, :role => "regular")
    puts user.production_admin?(prod)
    puts specialization.production_admin
    production.theater.jobs.create(user: user, specialization: specialization)
    log_in_as(user)
    visit(edit_play_path(play))
    expect(current_path).to eq(edit_play_path(play))
  end

  it "allows all users to view but not edit all plays" do
    prod = create(:production, :theater => theater, :play => noncanonical_play)
    play = create(:play, :canonical => false, :production_id => prod.id)
    log_in_as(user)
    visit(play_path(play))
    expect(current_path).to eq(play_path(play))
    visit(edit_play_path(play))
    expect(current_path).to eq("/")
  end
end