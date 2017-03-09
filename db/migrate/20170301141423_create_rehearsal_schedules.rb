class CreateRehearsalSchedules < ActiveRecord::Migration
  def change
    create_table :rehearsal_schedules do |t|
      t.belongs_to :production, index: true, foreign_key: true
      t.date :start_date
      t.date :end_date
      t.datetime :start_time
      t.datetime :end_time
      t.string :interval
      t.boolean :sunday
      t.boolean :monday
      t.boolean :tuesday
      t.boolean :wednesday
      t.boolean :thursday
      t.boolean :friday
      t.boolean :saturday

      t.timestamps null: false
    end
  end
end
