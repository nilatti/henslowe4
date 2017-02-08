require 'rails_helper'

RSpec.describe "lines/show", :type => :view do
  before(:each) do
    @line = assign(:line, Line.create!(
      :text => "Text",
      :belongs_to => "",
      :belongs_to => "",
      :type => "Type",
      :cut => false
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Text/)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(/Type/)
    expect(rendered).to match(/false/)
  end
end
