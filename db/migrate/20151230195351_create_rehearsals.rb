class CreateRehearsals < ActiveRecord::Migration
  def change
    create_table :rehearsals do |t|
      t.datetime :start_time
      t.datetime :end_time
      t.belongs_to :act, index: true, foreign_key: true
      t.belongs_to :scene, index: true, foreign_key: true
      t.belongs_to :french_scene, index: true, foreign_key: true
      t.belongs_to :space, index: true, foreign_key: true
      t.belongs_to :production, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
