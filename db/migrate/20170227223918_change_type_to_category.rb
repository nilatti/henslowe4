class ChangeTypeToCategory < ActiveRecord::Migration
  def change
    rename_column :conflicts, :type, :category
  end
end
