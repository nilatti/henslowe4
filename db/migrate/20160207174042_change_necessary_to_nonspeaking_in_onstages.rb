class ChangeNecessaryToNonspeakingInOnstages < ActiveRecord::Migration
  def change
    rename_column :on_stages, :necessary, :nonspeaking
  end
end
