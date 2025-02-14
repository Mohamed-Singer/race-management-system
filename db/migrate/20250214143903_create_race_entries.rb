class CreateRaceEntries < ActiveRecord::Migration[7.2]
  def change
    create_table :race_entries do |t|
      t.references :race, null: false, foreign_key: { on_delete: :cascade }
      t.string :student_name, null: false
      t.integer :lane, null: false
      t.integer :final_place
      t.timestamps
    end

    add_index :race_entries, [ :race_id, :student_name ], unique: true
    add_index :race_entries, [ :race_id, :lane ], unique: true
  end
end
