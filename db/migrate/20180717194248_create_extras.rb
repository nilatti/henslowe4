class CreateExtras < ActiveRecord::Migration
  def change
    create_table :extras do |t|
      t.references :french_scene, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true
      t.string :name
      t.boolean :needs_costume

      t.timestamps null: false
    end
  end
end
