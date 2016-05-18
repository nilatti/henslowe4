class AddProductionToPlays < ActiveRecord::Migration
  def change
    add_column :plays, :production_id, :integer
  end
end
