class ChangeLineType < ActiveRecord::Migration
  def change
    rename_column :lines, :type, :category
  end
end
