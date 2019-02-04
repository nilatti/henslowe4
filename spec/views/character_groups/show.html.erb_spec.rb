require 'rails_helper'

RSpec.describe "character_groups/show", type: :view do
  before(:each) do
    @character_group = assign(:character_group, CharacterGroup.create!(
      :name => "MyText",
      :play => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(//)
  end
end
