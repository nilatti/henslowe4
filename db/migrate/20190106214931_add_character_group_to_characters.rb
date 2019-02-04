class AddCharacterGroupToCharacters < ActiveRecord::Migration
  def change
    add_reference :characters, :character_group, index: true
  end
end
