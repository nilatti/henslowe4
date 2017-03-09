require 'rails_helper'

RSpec.describe "rehearsal_schedules/new", :type => :view do
  before(:each) do
    assign(:rehearsal_schedule, RehearsalSchedule.new(
      :production => nil,
      :interval => "MyString",
      :sunday => false,
      :monday => false,
      :tuesday => false,
      :wednesday => false,
      :thursday => false,
      :friday => false,
      :saturday => false
    ))
  end

  it "renders new rehearsal_schedule form" do
    render

    assert_select "form[action=?][method=?]", rehearsal_schedules_path, "post" do

      assert_select "input#rehearsal_schedule_production_id[name=?]", "rehearsal_schedule[production_id]"

      assert_select "input#rehearsal_schedule_interval[name=?]", "rehearsal_schedule[interval]"

      assert_select "input#rehearsal_schedule_sunday[name=?]", "rehearsal_schedule[sunday]"

      assert_select "input#rehearsal_schedule_monday[name=?]", "rehearsal_schedule[monday]"

      assert_select "input#rehearsal_schedule_tuesday[name=?]", "rehearsal_schedule[tuesday]"

      assert_select "input#rehearsal_schedule_wednesday[name=?]", "rehearsal_schedule[wednesday]"

      assert_select "input#rehearsal_schedule_thursday[name=?]", "rehearsal_schedule[thursday]"

      assert_select "input#rehearsal_schedule_friday[name=?]", "rehearsal_schedule[friday]"

      assert_select "input#rehearsal_schedule_saturday[name=?]", "rehearsal_schedule[saturday]"
    end
  end
end
