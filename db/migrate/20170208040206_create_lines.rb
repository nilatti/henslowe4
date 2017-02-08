class CreateLines < ActiveRecord::Migration
  def change
    create_table :lines do |t|
      t.string :text
      t.belongs_to :french_scene
      t.belongs_to :character
      t.string :type
      t.boolean :cut

      t.timestamps null: false
    end
  end
end
