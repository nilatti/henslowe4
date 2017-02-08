require 'rails_helper'

RSpec.describe "lines/index", :type => :view do
  before(:each) do
    assign(:lines, [
      Line.create!(
        :text => "Text",
        :belongs_to => "",
        :belongs_to => "",
        :type => "Type",
        :cut => false
      ),
      Line.create!(
        :text => "Text",
        :belongs_to => "",
        :belongs_to => "",
        :type => "Type",
        :cut => false
      )
    ])
  end

  it "renders a list of lines" do
    render
    assert_select "tr>td", :text => "Text".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "Type".to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
  end
end
