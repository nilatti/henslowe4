class AddScriptToPlays < ActiveRecord::Migration
  def change
    add_attachment :plays, :script

  end
end
