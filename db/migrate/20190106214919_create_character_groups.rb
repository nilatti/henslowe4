class CreateCharacterGroups < ActiveRecord::Migration
  def change
    create_table :character_groups do |t|
      t.text :name
      t.belongs_to :play, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
