class AddSeatNumbersToBookings < ActiveRecord::Migration[8.1]
  def change
    add_column :bookings, :seat_numbers, :string
  end
end
