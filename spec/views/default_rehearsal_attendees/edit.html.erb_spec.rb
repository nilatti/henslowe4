require 'rails_helper'

RSpec.describe "default_rehearsal_attendees/edit", :type => :view do
  before(:each) do
    @default_rehearsal_attendee = assign(:default_rehearsal_attendee, DefaultRehearsalAttendee.create!(
      :rehearsal_schedule => nil,
      :user => nil
    ))
  end

  it "renders the edit default_rehearsal_attendee form" do
    render

    assert_select "form[action=?][method=?]", default_rehearsal_attendee_path(@default_rehearsal_attendee), "post" do

      assert_select "input#default_rehearsal_attendee_rehearsal_schedule_id[name=?]", "default_rehearsal_attendee[rehearsal_schedule_id]"

      assert_select "input#default_rehearsal_attendee_user_id[name=?]", "default_rehearsal_attendee[user_id]"
    end
  end
end
