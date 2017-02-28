require 'rails_helper'

RSpec.describe "conflicts/show", :type => :view do
  before(:each) do
    @conflict = assign(:conflict, Conflict.create!(
      :user => nil,
      :type => "Type"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(/Type/)
  end
end
