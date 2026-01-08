class CreateBookings < ActiveRecord::Migration[8.1]
  def change
    create_table :bookings do |t|
      t.references :user, null: false, foreign_key: true
      t.references :show, null: false, foreign_key: true
      t.integer :number_of_seats
      t.decimal :total_price
      t.string :status

      t.timestamps
    end
  end
end
