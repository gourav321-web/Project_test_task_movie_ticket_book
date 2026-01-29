class AddShowTimeToBookings < ActiveRecord::Migration[8.1]
  def change
    add_column :bookings, :show_time, :datetime
  end
end
