class CreateTheaters < ActiveRecord::Migration
  def change
    create_table :theaters do |t|
      t.string :name
      t.string :street_address
      t.string :city
      t.string :state
      t.string :zip
      t.string :phone_number
      t.text :mission_statement
      t.string :website
      t.string :calendar

      t.timestamps null: false
    end
  end
end
