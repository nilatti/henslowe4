class DropProductionIdFromRehearsals < ActiveRecord::Migration
  def change
    remove_foreign_key :rehearsals, :productions
  end
end
