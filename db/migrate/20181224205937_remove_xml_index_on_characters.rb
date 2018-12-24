class RemoveXmlIndexOnCharacters < ActiveRecord::Migration
  def change
    remove_index :characters, :xml_id
  end
end
