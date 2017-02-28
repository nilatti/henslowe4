require 'rails_helper'

RSpec.describe "conflicts/edit", :type => :view do
  before(:each) do
    @conflict = assign(:conflict, Conflict.create!(
      :user => nil,
      :type => ""
    ))
  end

  it "renders the edit conflict form" do
    render

    assert_select "form[action=?][method=?]", conflict_path(@conflict), "post" do

      assert_select "input#conflict_user_id[name=?]", "conflict[user_id]"

      assert_select "input#conflict_type[name=?]", "conflict[type]"
    end
  end
end
