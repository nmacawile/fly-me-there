class DropUsers < ActiveRecord::Migration[5.0]
  def change
    remove_reference :bookings, :user, index: true, foreign_key: true
    remove_column :bookings, :passengers
    drop_table :users
  end
end
