class CreateDefaultRehearsalAttendees < ActiveRecord::Migration
  def change
    create_table :default_rehearsal_attendees do |t|
      t.belongs_to :rehearsal_schedule, index: true, foreign_key: true
      t.belongs_to :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
