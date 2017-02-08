require 'rails_helper'

RSpec.describe "lines/new", :type => :view do
  before(:each) do
    assign(:line, Line.new(
      :text => "MyString",
      :belongs_to => "",
      :belongs_to => "",
      :type => "",
      :cut => false
    ))
  end

  it "renders new line form" do
    render

    assert_select "form[action=?][method=?]", lines_path, "post" do

      assert_select "input#line_text[name=?]", "line[text]"

      assert_select "input#line_belongs_to[name=?]", "line[belongs_to]"

      assert_select "input#line_belongs_to[name=?]", "line[belongs_to]"

      assert_select "input#line_type[name=?]", "line[type]"

      assert_select "input#line_cut[name=?]", "line[cut]"
    end
  end
end
