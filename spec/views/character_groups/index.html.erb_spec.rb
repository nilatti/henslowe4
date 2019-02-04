require 'rails_helper'

RSpec.describe "character_groups/index", type: :view do
  before(:each) do
    assign(:character_groups, [
      CharacterGroup.create!(
        :name => "MyText",
        :play => nil
      ),
      CharacterGroup.create!(
        :name => "MyText",
        :play => nil
      )
    ])
  end

  it "renders a list of character_groups" do
    render
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
