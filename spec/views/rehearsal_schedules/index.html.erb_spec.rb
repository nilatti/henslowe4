require 'rails_helper'

RSpec.describe "rehearsal_schedules/index", :type => :view do
  before(:each) do
    assign(:rehearsal_schedules, [
      RehearsalSchedule.create!(
        :production => nil,
        :interval => "Interval",
        :sunday => false,
        :monday => false,
        :tuesday => false,
        :wednesday => false,
        :thursday => false,
        :friday => false,
        :saturday => false
      ),
      RehearsalSchedule.create!(
        :production => nil,
        :interval => "Interval",
        :sunday => false,
        :monday => false,
        :tuesday => false,
        :wednesday => false,
        :thursday => false,
        :friday => false,
        :saturday => false
      )
    ])
  end

  it "renders a list of rehearsal_schedules" do
    render
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => "Interval".to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
  end
end
