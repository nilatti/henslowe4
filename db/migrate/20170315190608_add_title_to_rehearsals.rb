class AddTitleToRehearsals < ActiveRecord::Migration
  def change
    add_column :rehearsals, :title, :string

  end
end
