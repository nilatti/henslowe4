class AddPageNumbersToScenes < ActiveRecord::Migration
  def change
    add_column :scenes, :start_page, :integer
    add_column :scenes, :end_page, :integer
  end
end
