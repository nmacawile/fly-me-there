require 'test_helper'

class BookingTest < ActiveSupport::TestCase
  def setup
    flight = flights(:foobar_to_baz)
    user = users(:test)
    @booking = Booking.new(user: user, flight: flight)
  end
  
  test "should be valid" do
    assert @booking.valid?
  end
  
  test "user should not be blank" do
    @booking.user = nil
    assert_not @booking.valid?
  end
  
  test "flight should not be blank" do
    @booking.flight = nil
    assert_not @booking.valid?
  end
end
