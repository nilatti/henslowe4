class AddRehearsalScheduleToRehearsals < ActiveRecord::Migration
  def change
    add_foreign_key :rehearsals, :rehearsal_schedules, column: :rehearsal_schedule_id
  end
end
