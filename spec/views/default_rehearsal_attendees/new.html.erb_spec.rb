require 'rails_helper'

RSpec.describe "default_rehearsal_attendees/new", :type => :view do
  before(:each) do
    assign(:default_rehearsal_attendee, DefaultRehearsalAttendee.new(
      :rehearsal_schedule => nil,
      :user => nil
    ))
  end

  it "renders new default_rehearsal_attendee form" do
    render

    assert_select "form[action=?][method=?]", default_rehearsal_attendees_path, "post" do

      assert_select "input#default_rehearsal_attendee_rehearsal_schedule_id[name=?]", "default_rehearsal_attendee[rehearsal_schedule_id]"

      assert_select "input#default_rehearsal_attendee_user_id[name=?]", "default_rehearsal_attendee[user_id]"
    end
  end
end
