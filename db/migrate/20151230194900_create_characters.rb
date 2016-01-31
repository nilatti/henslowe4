class CreateCharacters < ActiveRecord::Migration
  def change
    create_table :characters do |t|
      t.string :name
      t.integer :age
      t.boolean :is_female
      t.belongs_to :play, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
