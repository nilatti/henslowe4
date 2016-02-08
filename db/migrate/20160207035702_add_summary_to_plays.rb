class AddSummaryToPlays < ActiveRecord::Migration
  def change
    add_column :plays, :summary, :text
  end
end
