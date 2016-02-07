class ChangeGenderToTextFieldOnCharacters < ActiveRecord::Migration
  def change
    change_column :characters, :is_female, :text

  end
end
