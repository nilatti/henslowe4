class CreateSpaces < ActiveRecord::Migration
  def change
    create_table :spaces do |t|
      t.string :name
      t.string :street_address
      t.string :city
      t.string :state
      t.string :zip
      t.string :phone_number
      t.string :website
      t.integer :seating_capacity
      t.string :calendar
      t.belongs_to :theater, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
