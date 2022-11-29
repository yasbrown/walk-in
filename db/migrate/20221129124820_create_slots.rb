class CreateSlots < ActiveRecord::Migration[7.0]
  def change
    create_table :slots do |t|
      t.datetime :date
      t.boolean :available?, default: true
      t.timestamps
      t.references :cover, null: false, foreign_key: true
    end
  end
end
