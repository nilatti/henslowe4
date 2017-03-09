class FixFrenchSceneIdInRehearsalJoinTable < ActiveRecord::Migration
  def change
    rename_column :french_scenes_rehearsals, :french_scenes_id, :french_scene_id
  end
end
