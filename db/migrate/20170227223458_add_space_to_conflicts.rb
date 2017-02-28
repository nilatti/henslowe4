class AddSpaceToConflicts < ActiveRecord::Migration
  def change
    add_reference :conflicts, :space, index: true, foreign_key: true
  end
end
