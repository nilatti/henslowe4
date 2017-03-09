require 'rails_helper'

RSpec.describe "rehearsal_schedules/show", :type => :view do
  before(:each) do
    @rehearsal_schedule = assign(:rehearsal_schedule, RehearsalSchedule.create!(
      :production => nil,
      :interval => "Interval",
      :sunday => false,
      :monday => false,
      :tuesday => false,
      :wednesday => false,
      :thursday => false,
      :friday => false,
      :saturday => false
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(/Interval/)
    expect(rendered).to match(/false/)
    expect(rendered).to match(/false/)
    expect(rendered).to match(/false/)
    expect(rendered).to match(/false/)
    expect(rendered).to match(/false/)
    expect(rendered).to match(/false/)
    expect(rendered).to match(/false/)
  end
end
