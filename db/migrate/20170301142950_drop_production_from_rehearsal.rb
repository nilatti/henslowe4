class DropProductionFromRehearsal < ActiveRecord::Migration
  def change
    remove_column :rehearsals, :production_id
  end
end
