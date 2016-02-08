class AddSummaryToActs < ActiveRecord::Migration
  def change
    add_column :acts, :summary, :text
  end
end
