class AddNotesToRehearsals < ActiveRecord::Migration
  def change
    add_column :rehearsals, :notes, :text
  end
end
