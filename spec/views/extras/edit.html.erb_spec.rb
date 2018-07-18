require 'rails_helper'

RSpec.describe "extras/edit", :type => :view do
  before(:each) do
    @extra = assign(:extra, Extra.create!(
      :french_scene => nil,
      :user => nil,
      :name => "MyString",
      :needs_costume => false
    ))
  end

  it "renders the edit extra form" do
    render

    assert_select "form[action=?][method=?]", extra_path(@extra), "post" do

      assert_select "input#extra_french_scene_id[name=?]", "extra[french_scene_id]"

      assert_select "input#extra_user_id[name=?]", "extra[user_id]"

      assert_select "input#extra_name[name=?]", "extra[name]"

      assert_select "input#extra_needs_costume[name=?]", "extra[needs_costume]"
    end
  end
end
