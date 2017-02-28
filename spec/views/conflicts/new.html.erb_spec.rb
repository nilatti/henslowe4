require 'rails_helper'

RSpec.describe "conflicts/new", :type => :view do
  before(:each) do
    assign(:conflict, Conflict.new(
      :user => nil,
      :type => ""
    ))
  end

  it "renders new conflict form" do
    render

    assert_select "form[action=?][method=?]", conflicts_path, "post" do

      assert_select "input#conflict_user_id[name=?]", "conflict[user_id]"

      assert_select "input#conflict_type[name=?]", "conflict[type]"
    end
  end
end
