class AddPlayToRehearsals < ActiveRecord::Migration
  def change
    add_reference :rehearsals, :play, index: true, foreign_key: true
  end
end
