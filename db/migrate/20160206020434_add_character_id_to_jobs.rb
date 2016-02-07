class AddCharacterIdToJobs < ActiveRecord::Migration
  def change
    add_column :jobs, :character_id, :integer
  end
end
