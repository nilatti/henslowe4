class CreateOnStages < ActiveRecord::Migration
  def change
    create_table :on_stages do |t|
      t.belongs_to :character, index: true, foreign_key: true
      t.belongs_to :french_scene, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
