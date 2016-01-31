class CreateJobs < ActiveRecord::Migration
  def change
    create_table :jobs do |t|
      t.belongs_to :user, index: true, foreign_key: true
      t.belongs_to :specialization, index: true, foreign_key: true
      t.belongs_to :production, index: true, foreign_key: true
      t.belongs_to :theater, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
