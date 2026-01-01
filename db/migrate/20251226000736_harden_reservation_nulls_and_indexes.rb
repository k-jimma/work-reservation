class HardenReservationNullsAndIndexes < ActiveRecord::Migration[7.2]
  def change
    change_column_null :reservations, :user_id, false
    change_column_null :reservations, :room_id, false
    change_column_null :reservations, :check_in_on, false
    change_column_null :reservations, :check_out_on, false
    change_column_null :reservations, :guests_count, false
    add_index :reservations, :created_at
    add_index :reservations, [ :room_id, :check_in_on, :check_out_on ]
  end
end
