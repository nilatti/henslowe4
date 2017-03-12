class CreateRehearsalCalls < ActiveRecord::Migration
  def change
    create_table :rehearsal_calls do |t|
      t.belongs_to :rehearsal, index: true, foreign_key: true
      t.belongs_to :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
