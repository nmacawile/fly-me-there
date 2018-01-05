class CreateCountries < ActiveRecord::Migration[5.0]
  def change
    create_table :countries do |t|
      t.string :name
      t.string :iso

      t.timestamps
    end
    
    add_index :countries, :iso, unique: true
  end
end
