require "rails_helper"

RSpec.describe DefaultRehearsalAttendeesController, :type => :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/default_rehearsal_attendees").to route_to("default_rehearsal_attendees#index")
    end

    it "routes to #new" do
      expect(:get => "/default_rehearsal_attendees/new").to route_to("default_rehearsal_attendees#new")
    end

    it "routes to #show" do
      expect(:get => "/default_rehearsal_attendees/1").to route_to("default_rehearsal_attendees#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/default_rehearsal_attendees/1/edit").to route_to("default_rehearsal_attendees#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/default_rehearsal_attendees").to route_to("default_rehearsal_attendees#create")
    end

    it "routes to #update" do
      expect(:put => "/default_rehearsal_attendees/1").to route_to("default_rehearsal_attendees#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/default_rehearsal_attendees/1").to route_to("default_rehearsal_attendees#destroy", :id => "1")
    end

  end
end
