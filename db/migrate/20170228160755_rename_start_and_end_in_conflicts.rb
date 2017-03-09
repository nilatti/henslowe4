class RenameStartAndEndInConflicts < ActiveRecord::Migration
  def change
    rename_column :conflicts, :start, :start_time
    rename_column :conflicts, :end, :end_time
  end
end
