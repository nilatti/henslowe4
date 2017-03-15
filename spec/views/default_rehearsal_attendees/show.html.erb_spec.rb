require 'rails_helper'

RSpec.describe "default_rehearsal_attendees/show", :type => :view do
  before(:each) do
    @default_rehearsal_attendee = assign(:default_rehearsal_attendee, DefaultRehearsalAttendee.create!(
      :rehearsal_schedule => nil,
      :user => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(//)
  end
end
