class AddShowStatusToBookings < ActiveRecord::Migration[8.1]
  def change
    add_column :bookings, :show_status, :string, default: "active"
  end
end
