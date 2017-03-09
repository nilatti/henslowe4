class DropForeignKeysFromRehearsals < ActiveRecord::Migration
  def change
    remove_column :rehearsals, :french_scene_id
    remove_column :rehearsals, :scene_id
    remove_column :rehearsals, :act_id
    remove_column :rehearsals, :play_id
  end
end
