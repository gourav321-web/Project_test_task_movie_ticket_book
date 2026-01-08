class CreateShows < ActiveRecord::Migration[8.1]
  def change
    create_table :shows do |t|
      t.references :movie, null: false, foreign_key: true
      t.datetime :show_time
      t.integer :available_seats
      t.decimal :seat_price

      t.timestamps
    end
  end
end
