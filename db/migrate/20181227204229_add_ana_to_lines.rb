class AddAnaToLines < ActiveRecord::Migration
  def change
    add_column :lines, :ana, :string
  end
end
