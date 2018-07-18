require 'rails_helper'

RSpec.describe "extras/show", :type => :view do
  before(:each) do
    @extra = assign(:extra, Extra.create!(
      :french_scene => nil,
      :user => nil,
      :name => "Name",
      :needs_costume => false
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/false/)
  end
end
