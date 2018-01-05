class CreateFlights < ActiveRecord::Migration[5.0]
  def change
    create_table :flights do |t|
      t.references :origin, index: true
      t.references :destination, index: true
      t.datetime :depart
      t.datetime :arrive
      t.integer :capacity
      t.decimal :fare

      t.timestamps
    end
    
    add_foreign_key :flights, :airports, column: :origin_id
    add_foreign_key :flights, :airports, column: :destination_id
    add_index :flights, [:origin_id, :destination_id]
  end
end
