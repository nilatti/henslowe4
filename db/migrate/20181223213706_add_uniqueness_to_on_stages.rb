class AddUniquenessToOnStages < ActiveRecord::Migration
  def change
    add_index :on_stages, [:french_scene_id, :character_id], :unique => true
  end
end
