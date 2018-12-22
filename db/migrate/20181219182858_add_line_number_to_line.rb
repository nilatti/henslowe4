class AddLineNumberToLine < ActiveRecord::Migration
  def change
    add_column :lines, :line_number, :string
  end
end
