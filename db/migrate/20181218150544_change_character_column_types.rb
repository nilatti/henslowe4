class ChangeCharacterColumnTypes < ActiveRecord::Migration
  def change
    change_column :characters, :description, :text
    change_column :characters, :gender, :string
  end
end
