require 'rails_helper'

RSpec.describe "DefaultRehearsalAttendees", :type => :request do
  describe "GET /default_rehearsal_attendees" do
    it "works! (now write some real specs)" do
      get default_rehearsal_attendees_path
      expect(response.status).to be(200)
    end
  end
end
