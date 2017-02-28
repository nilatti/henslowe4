class CreateConflicts < ActiveRecord::Migration
  def change
    create_table :conflicts do |t|
      t.belongs_to :user, index: true, foreign_key: true
      t.datetime :start
      t.datetime :end
      t.string :type

      t.timestamps null: false
    end
  end
end
