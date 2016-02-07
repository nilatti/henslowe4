class ChangeCharacterAgeToText < ActiveRecord::Migration
  def change
    change_column :characters, :age, :string
  end
end
