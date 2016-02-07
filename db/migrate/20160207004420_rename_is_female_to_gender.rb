class RenameIsFemaleToGender < ActiveRecord::Migration
  def change
    rename_column :characters, :is_female, :gender
  end
end
