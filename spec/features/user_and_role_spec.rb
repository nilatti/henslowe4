require "rails_helper"

describe "with users and roles" do 
  
  def log_in_as(user)
  	visit new_user_session_path
  	fill_in("user_email", with: user.email)
  	fill_in("user_password", with: user.password)
    click_button("Log in")
  end

  let(:user) { User.create(email: "test@example.com", password: "password", role: "regular") }
  let(:superuser) { User.create(email: "super@example.com", password: "password", role: "superadmin") }
  let(:user_2) { User.create(email: "stooge@example.com", password: "password", role: "regular")}

  it "redirects a not-logged-in-user to welcome page" do
    visit(authors_path)
    expect(current_path).to eq("/")
  end
  
  it "allows a logged-in user to view the authors index page" do
  	log_in_as(user)
  	visit(authors_path)
  	expect(current_path).to eq(authors_path)
  end

  it "allows a superadmin to see users index" do
    log_in_as(superuser)
    visit "/users"
  end

  it "does not allow a not-superadmin to see users index" do #not working, not sure why
    log_in_as(user)
    visit "/users"
    expect(current_path).to eq("/")
  end

describe "roles" do 
  let(:play) { FactoryBot.create(:play, :canonical => true) }
  let(:theater) { FactoryBot.create(:theater) }
  let(:production) { FactoryBot.create(:production, :theater => theater, :play => play) }

#manage users

  it "allows a user to edit their own profile" do
    log_in_as(user)
    visit "/users/#{user.id}/edit"
    expect(current_path).to eq("/users/#{user.id}/edit")
  end

  it "does not allow a user to edit someone else's profile" do
    log_in_as(user)
    visit "/users/#{user_2.id}/edit"
    expect(current_path).to eq("/")
  end

  it "allows a user to view another user's profile if they have a theater in common" do
  end

#manage productions

  it "allows a user who is part of a production to see that production" do
    specialization = create(:specialization, :actor)
    production.jobs.create(user: user, specialization: specialization)
    log_in_as(user)
    visit(production_path(production))
    expect(current_path).to eq(production_path(production))
  end

  it "does not allow a user who is not part of the production or theater to see the production" do
    log_in_as(user)
    visit(production_path(production))
    expect(current_path).to eq("/")
  end

  it "allows a user who is a theater admin but not part of production to see production." do
    specialization = create(:specialization, :executive_director)
    production.theater.jobs.create(user: user, specialization: specialization)
    log_in_as(user)
    visit(production_path(production))
    expect(current_path).to eq(production_path(production))
  end

  it "does not allow a user who is part of another production at the theater but not a theater admin to see the production" do
    specialization = create(:specialization, :actor)
    job = FactoryBot.create(:job, user: user, specialization: specialization)
    log_in_as(user)
    visit(production_path(production))
    expect(current_path).to eq("/")
  end

  it "allows a user who is a theater admin to edit production" do
    specialization = create(:specialization, :executive_director)
    theater.jobs.create(user: user, specialization: specialization)
    log_in_as(user)
    visit(edit_production_path(production))
    expect(current_path).to eq(edit_production_path(production))
  end

  it "allows a user who is a production admin to edit production" do
    specialization = create(:specialization, :production_manager)
    production.jobs.create(user: user, specialization: specialization)
    log_in_as(user)
    visit(edit_production_path(production))
    expect(current_path).to eq(edit_production_path(production))
  end

  it "does not allow a member of the production who is not a production admin or theater admin to edit production" do
    specialization = create(:specialization, :actor)
    production.theater.jobs.create(user: user, specialization: specialization)
    log_in_as(user)
    visit(edit_production_path(production))
    expect(current_path).to eq("/")
  end


#manage theater

  it "allows a user who is a theater admin to edit theater" do
    specialization = create(:specialization, :executive_director)
    production.theater.jobs.create(user: user, specialization: specialization)
    log_in_as(user)
    visit(edit_theater_path(theater))
    expect(current_path).to eq(edit_theater_path(theater))
  end

  it "does not allow a user who is not a theater admin to edit theater, even if they are a production admin" do
    specialization = create(:specialization, :production_manager)
    production.theater.jobs.create(user: user, specialization: specialization)
    log_in_as(user)
    visit(edit_theater_path(theater))
    expect(current_path).to eq("/")
  end

  it "allows a user associated with theater to see theater" do
    specialization = create(:specialization, :production_manager)
    theater.jobs.create(user: user, specialization: specialization)
    log_in_as(user)
    visit(theater_path(theater))
    expect(current_path).to eq(theater_path(theater))
  end


  #manage jobs

  it "allows theater manager to manage jobs" do
    specialization = create(:specialization, :executive_director)
    job = Job.create(:theater => theater, :user => user, :specialization => specialization, :production => production)
    log_in_as(user)
    visit(edit_job_path(job))
    expect(current_path).to eq(edit_job_path(job))
  end

  it "allows production manager to edit jobs" do 
    specialization = create(:specialization, :production_manager)
    job = Job.create(:theater => theater, :user => user, :specialization => specialization, :production => production)
    log_in_as(user)
    visit(edit_job_path(job))
    expect(current_path).to eq(edit_job_path(job))
  end

  it "allows user to see own jobs" do
    specialization = create(:specialization, :actor)
    job = Job.create(:theater => theater, :user => user, :specialization => specialization, :production => production)
    log_in_as(user)
    visit(job_path(job))
    expect(current_path).to eq(job_path(job))
  end

  it "does not allow other users to view jobs" do
    specialization = create(:specialization, :actor)
    job = Job.create(:theater => theater, :user => user, :specialization => specialization, :production => production)
    
    log_in_as(user_2)
    
    visit(job_path(job))
    expect(current_path).to eq("/")
  end

end
  
end
