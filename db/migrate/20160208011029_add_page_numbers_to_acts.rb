class AddPageNumbersToActs < ActiveRecord::Migration
  def change
    add_column :acts, :start_page, :integer
    add_column :acts, :end_page, :integer
  end
end
