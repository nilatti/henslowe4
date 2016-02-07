class AddCanonicalToPlay < ActiveRecord::Migration
  def change
    add_column :plays, :canonical, :boolean
  end
end
