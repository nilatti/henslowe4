class AddProductionAdminandTheaterAdminToSpecializations < ActiveRecord::Migration
  def change
    add_column :specializations, :production_admin, :boolean
    add_column :specializations, :theater_admin, :boolean
  end
end
