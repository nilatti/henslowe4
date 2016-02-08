class AddPageNumbersToFrenchScenes < ActiveRecord::Migration
  def change
    add_column :french_scenes, :start_page, :integer
    add_column :french_scenes, :end_page, :integer
  end
end
