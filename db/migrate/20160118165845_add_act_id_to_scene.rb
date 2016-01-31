class AddActIdToScene < ActiveRecord::Migration
  def change
    add_column :scenes, :act_id, :integer
  end
end
