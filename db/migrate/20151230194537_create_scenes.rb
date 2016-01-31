class CreateScenes < ActiveRecord::Migration
  def change
    create_table :scenes do |t|
      t.integer :scene_number
      t.belongs_to :play, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
