class AddXmlIdToCharacterGroup < ActiveRecord::Migration
  def change
    add_column :character_groups, :xml_id, :string
  end
end
