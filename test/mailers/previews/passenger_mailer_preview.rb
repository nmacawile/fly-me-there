# Preview all emails at http://localhost:3000/rails/mailers/passenger_mailer
class PassengerMailerPreview < ActionMailer::Preview
  def booking_email
    PassengerMailer.booking_email(Passenger.first)
  end
end
