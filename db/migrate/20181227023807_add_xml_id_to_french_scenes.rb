class AddXmlIdToFrenchScenes < ActiveRecord::Migration
  def change
    add_column :french_scenes, :starting_xml_id, :string
  end
end
