require 'rails_helper'

RSpec.describe "character_groups/edit", type: :view do
  before(:each) do
    @character_group = assign(:character_group, CharacterGroup.create!(
      :name => "MyText",
      :play => nil
    ))
  end

  it "renders the edit character_group form" do
    render

    assert_select "form[action=?][method=?]", character_group_path(@character_group), "post" do

      assert_select "textarea#character_group_name[name=?]", "character_group[name]"

      assert_select "input#character_group_play_id[name=?]", "character_group[play_id]"
    end
  end
end
