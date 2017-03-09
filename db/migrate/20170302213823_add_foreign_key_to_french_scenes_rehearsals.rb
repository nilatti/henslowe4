class AddForeignKeyToFrenchScenesRehearsals < ActiveRecord::Migration
  def change
    add_foreign_key :french_scenes_rehearsals, :french_scenes
  end
end
