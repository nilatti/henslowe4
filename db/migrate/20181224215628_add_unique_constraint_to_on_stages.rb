class AddUniqueConstraintToOnStages < ActiveRecord::Migration
  def change
    add_index :on_stages, [:character_id, :french_scene_id], unique: true
  end
end
