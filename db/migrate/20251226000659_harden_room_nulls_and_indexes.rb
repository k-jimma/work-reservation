class HardenRoomNullsAndIndexes < ActiveRecord::Migration[7.2]
  def change
    change_column_null :rooms, :user_id, false
    change_column_null :rooms, :title, false
    change_column_null :rooms, :description, false
    change_column_null :rooms, :address, false
    change_column_null :rooms, :price_per_night, false
    add_index :rooms, :created_at
    add_index :rooms, :address
  end
end
