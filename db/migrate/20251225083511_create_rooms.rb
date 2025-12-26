class CreateRooms < ActiveRecord::Migration[7.2]
  def change
    create_table :rooms do |t|
      t.references :user, null: false, foreign_key: true
      t.string :title
      t.text :description
      t.string :address
      t.integer :price_per_night

      t.timestamps
    end
  end
end
