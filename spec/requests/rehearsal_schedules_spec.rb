require 'rails_helper'

RSpec.describe "RehearsalSchedules", :type => :request do
  describe "GET /rehearsal_schedules" do
    it "works! (now write some real specs)" do
      get rehearsal_schedules_path
      expect(response.status).to be(200)
    end
  end
end
