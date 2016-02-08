class AddNecessaryToOnStages < ActiveRecord::Migration
  def change
    add_column :on_stages, :necessary, :boolean
  end
end
