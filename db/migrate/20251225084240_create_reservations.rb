class CreateReservations < ActiveRecord::Migration[7.2]
  def change
    create_table :reservations do |t|
      t.references :user, null: false, foreign_key: true
      t.references :room, null: false, foreign_key: true
      t.date :check_in_on
      t.date :check_out_on
      t.integer :guests_count
      t.datetime :confirmed_at

      t.timestamps
    end
  end
end
