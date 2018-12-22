class AddDescriptionToCharacters < ActiveRecord::Migration
  def change
    add_column :characters, :description, :string

  end
end
