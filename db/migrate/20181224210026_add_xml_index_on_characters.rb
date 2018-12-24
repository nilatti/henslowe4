class AddXmlIndexOnCharacters < ActiveRecord::Migration
  def change
    add_index :characters, :xml_id
  end
end
