class CreatePlays < ActiveRecord::Migration
  def change
    create_table :plays do |t|
      t.string :title
      t.date :date
      t.belongs_to :author, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
