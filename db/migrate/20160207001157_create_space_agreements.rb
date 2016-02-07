class CreateSpaceAgreements < ActiveRecord::Migration
  def change
    create_table :space_agreements do |t|
      t.belongs_to :theater, index: true, foreign_key: true
      t.belongs_to :space, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
