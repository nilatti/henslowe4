require 'rails_helper'

RSpec.describe "Lines", :type => :request do
  describe "GET /lines" do
    it "works! (now write some real specs)" do
      get lines_path
      expect(response.status).to be(200)
    end
  end
end
