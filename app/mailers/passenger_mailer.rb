class PassengerMailer < ApplicationMailer
  default from: "booking@flymethere.com"
  def booking_email(passenger)
    @passenger = passenger
    @booking = passenger.booking
    @flight = @booking.flight
    mail(to: @passenger.email, subject: "Thank you for booking!")
  end
end
