require "rails_helper"

RSpec.describe RehearsalSchedulesController, :type => :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/rehearsal_schedules").to route_to("rehearsal_schedules#index")
    end

    it "routes to #new" do
      expect(:get => "/rehearsal_schedules/new").to route_to("rehearsal_schedules#new")
    end

    it "routes to #show" do
      expect(:get => "/rehearsal_schedules/1").to route_to("rehearsal_schedules#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/rehearsal_schedules/1/edit").to route_to("rehearsal_schedules#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/rehearsal_schedules").to route_to("rehearsal_schedules#create")
    end

    it "routes to #update" do
      expect(:put => "/rehearsal_schedules/1").to route_to("rehearsal_schedules#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/rehearsal_schedules/1").to route_to("rehearsal_schedules#destroy", :id => "1")
    end

  end
end
