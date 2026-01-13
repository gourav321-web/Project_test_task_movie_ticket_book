// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"

// seat selection js

document.addEventListener("turbo:load", () => {
  let selectedSeats = [];

  document.querySelectorAll(".seat").forEach(seat => {
    const seatNo = seat.dataset.seat;

    if (window.bookedSeats.includes(seatNo)) {
      seat.classList.add("booked");
      return;
    }

    seat.addEventListener("click", () => {
      if (seat.classList.contains("booked")) return;

      seat.classList.toggle("selected");

      if (selectedSeats.includes(seatNo)) {
        selectedSeats = selectedSeats.filter(s => s !== seatNo);
      } else {
        selectedSeats.push(seatNo);
      }

      document.getElementById("seat_numbers").value =
        selectedSeats.join(",");
    });
  });
});
