class CreateFrenchScenes < ActiveRecord::Migration
  def change
    create_table :french_scenes do |t|
      t.string :french_scene_number
      t.belongs_to :scene, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
