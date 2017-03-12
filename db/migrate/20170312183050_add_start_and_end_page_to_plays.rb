class AddStartAndEndPageToPlays < ActiveRecord::Migration
  def change
    add_column :plays, :start_page, :integer
    add_column :plays, :end_page, :integer
  end
end
