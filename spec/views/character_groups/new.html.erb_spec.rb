require 'rails_helper'

RSpec.describe "character_groups/new", type: :view do
  before(:each) do
    assign(:character_group, CharacterGroup.new(
      :name => "MyText",
      :play => nil
    ))
  end

  it "renders new character_group form" do
    render

    assert_select "form[action=?][method=?]", character_groups_path, "post" do

      assert_select "textarea#character_group_name[name=?]", "character_group[name]"

      assert_select "input#character_group_play_id[name=?]", "character_group[play_id]"
    end
  end
end
