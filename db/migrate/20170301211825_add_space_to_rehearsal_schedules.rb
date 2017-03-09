class AddSpaceToRehearsalSchedules < ActiveRecord::Migration
  def change
    add_reference :rehearsal_schedules, :space, index: true, foreign_key: true
  end
end
