require 'test_helper'

class PassengerTest < ActiveSupport::TestCase
  def setup
    @passenger = Passenger.new(name: "Example Passenger",
                               email: "example@email.com",
                               booking: bookings(:spongebob_foobar_to_baz))
  end
  
  test "should be valid" do
    assert @passenger.valid?
  end
  
  test "name should not be blank" do
    @passenger.name = "  "
    assert_not @passenger.valid?
  end
  
  test "email should not be blank" do
    @passenger.email = "  "
    assert_not @passenger.valid?
  end
  
  test "email should be saved as lowercase" do
    @passenger.email = "VaLiD@emAiL.cOm"
    @passenger.save
    @passenger.reload
    assert_equal @passenger.email, "valid@email.com"
  end
end
