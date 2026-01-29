require 'csv'

class Show < ApplicationRecord
  belongs_to :movie
  has_many :bookings, dependent: :destroy
  
  validates :show_time, presence: true
  validates :available_seats, presence: true, numericality: {only_integer: true,greater_than: 0,less_than_or_equal_to: 120}
  validates :seat_price, presence: true, numericality: {only_integer: true, greater_than: 0,less_than_or_equal_to: 1000}
  validates :show_time, presence: true, uniqueness: { scope: :movie_id} 

  def self.import_from_csv(movie)
    byebug
    @movie = movie
    # Assuming shows.csv is in the application's root directory or a specific data folder
    file_path = File.join(Rails.root, 'shows.csv')
    
    # byebug
    CSV.foreach(file_path, headers: true) do |row|
      # byebug
      # Create a Show record from each row's data
      # flag = Show.find_by(show_time: row["show_time"])
      # @show = @movie.shows.new(row.to_hash)
      @show =  Show.new(row.to_hash)
      byebug
      @show.movie_id = @movie
      byebug
      @show.save!
    end
  end
end
