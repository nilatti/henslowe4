class AddSummaryToScenes < ActiveRecord::Migration
  def change
    add_column :scenes, :summary, :text
  end
end
