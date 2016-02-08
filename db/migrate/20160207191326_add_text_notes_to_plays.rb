class AddTextNotesToPlays < ActiveRecord::Migration
  def change
    add_column :plays, :text_notes, :text
  end
end
