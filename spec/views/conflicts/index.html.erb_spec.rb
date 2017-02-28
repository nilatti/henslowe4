require 'rails_helper'

RSpec.describe "conflicts/index", :type => :view do
  before(:each) do
    assign(:conflicts, [
      Conflict.create!(
        :user => nil,
        :type => "Type"
      ),
      Conflict.create!(
        :user => nil,
        :type => "Type"
      )
    ])
  end

  it "renders a list of conflicts" do
    render
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => "Type".to_s, :count => 2
  end
end
