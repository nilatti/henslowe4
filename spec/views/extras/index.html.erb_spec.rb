require 'rails_helper'

RSpec.describe "extras/index", :type => :view do
  before(:each) do
    assign(:extras, [
      Extra.create!(
        :french_scene => nil,
        :user => nil,
        :name => "Name",
        :needs_costume => false
      ),
      Extra.create!(
        :french_scene => nil,
        :user => nil,
        :name => "Name",
        :needs_costume => false
      )
    ])
  end

  it "renders a list of extras" do
    render
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
  end
end
