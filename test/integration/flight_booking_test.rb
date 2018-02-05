require 'test_helper'

class FlightBookingTest < ActionDispatch::IntegrationTest
  def setup
    @booking_params = { params: { booking: { flight_id: flights(:foobar_to_baz2).id,
                                             passengers_attributes: [ { name: "pass1", email: "pass1@email.com" },
                                                                      { name: "pass2", email: "pass2@email.com" },
                                                                      { name: "pass3", email: "pass3@email.com" },
                                                                      { name: "pass4", email: "pass4@email.com" },
                                                                      { name: "pass5", email: "pass5@email.com" }
                                                                    ] } } }
  end
  
  test "should accept booking" do
    assert_difference "Booking.count", 1 do
      post bookings_path, @booking_params
    end
  end
  
  test "should save associated passenger data with the booking" do
    assert_difference "Passenger.count", 5 do
      post bookings_path, @booking_params
    end
  end
  
  test "should reject saving booking when the flight does not have enough available seats" do
    #skip
    @booking_params[:params][:booking][:flight_id] = flights(:foobar_to_baz).id
    assert_no_difference "Booking.count" do
      post bookings_path, @booking_params
    end
  end
end
