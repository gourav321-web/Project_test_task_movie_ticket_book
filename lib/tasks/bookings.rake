
namespace :bookings do
  desc "Update book status to complete if show time passed"
  task update_status: :environment do
    Booking.where(status: "book").update_all(status: 'complete')
    puts "Bookings updated to complete at #{Time.current}"
  end
end
