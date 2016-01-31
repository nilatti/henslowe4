class CreateProductions < ActiveRecord::Migration
  def change
    create_table :productions do |t|
      t.date :start_date
      t.date :end_date
      t.belongs_to :play, index: true, foreign_key: true
      t.belongs_to :theater, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
