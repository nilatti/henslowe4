class RemoveUniquenessConstraintOnStages < ActiveRecord::Migration
  def change
    remove_index :on_stages, [:french_scene_id, :character_id]
  end
end
