class AddXmlIdToCharacters < ActiveRecord::Migration
  def change
    add_column :characters, :xml_id, :string
  end
end
