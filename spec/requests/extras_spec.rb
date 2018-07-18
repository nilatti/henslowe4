require 'rails_helper'

RSpec.describe "Extras", :type => :request do
  describe "GET /extras" do
    it "works! (now write some real specs)" do
      get extras_path
      expect(response.status).to be(200)
    end
  end
end
