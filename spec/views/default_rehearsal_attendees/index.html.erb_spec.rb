require 'rails_helper'

RSpec.describe "default_rehearsal_attendees/index", :type => :view do
  before(:each) do
    assign(:default_rehearsal_attendees, [
      DefaultRehearsalAttendee.create!(
        :rehearsal_schedule => nil,
        :user => nil
      ),
      DefaultRehearsalAttendee.create!(
        :rehearsal_schedule => nil,
        :user => nil
      )
    ])
  end

  it "renders a list of default_rehearsal_attendees" do
    render
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
