class AddCorrespToCharacterGroups < ActiveRecord::Migration
  def change
    add_column :character_groups, :corresp, :string
  end
end
