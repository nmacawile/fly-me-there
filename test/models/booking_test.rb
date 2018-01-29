require 'test_helper'

class BookingTest < ActiveSupport::TestCase
  def setup
    flight = flights(:foobar_to_baz)
    @booking = Booking.new(flight: flight)
  end
  
  test "should be valid" do
    assert @booking.valid?
  end
  
  test "flight should not be blank" do
    @booking.flight = nil
    assert_not @booking.valid?
  end
end
