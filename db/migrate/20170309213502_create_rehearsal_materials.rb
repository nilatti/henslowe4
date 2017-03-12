class CreateRehearsalMaterials < ActiveRecord::Migration
  def change
    create_table :rehearsal_materials do |t|
      t.belongs_to :rehearsal, index: true, foreign_key: true
      t.belongs_to :play, index: true, foreign_key: true
      t.belongs_to :act, index: true, foreign_key: true
      t.belongs_to :scene, index: true, foreign_key: true
      t.belongs_to :french_scene, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
