class AddXmlIdIndexToCharacters < ActiveRecord::Migration
  def change
    add_index :characters, :xml_id, :unique => true
  end
end
