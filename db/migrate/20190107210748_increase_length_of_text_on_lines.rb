class IncreaseLengthOfTextOnLines < ActiveRecord::Migration
  def change
    change_column :lines, :text, :text
  end
end
