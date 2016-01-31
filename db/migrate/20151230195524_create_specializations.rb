class CreateSpecializations < ActiveRecord::Migration
  def change
    create_table :specializations do |t|
      t.string :title
      t.text :description

      t.timestamps null: false
    end
  end
end
