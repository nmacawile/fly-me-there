require 'test_helper'

class FlightTest < ActiveSupport::TestCase
  def setup
    origin = airports(:foobar)
    destination = airports(:baz)
    @flight = Flight.new(origin: origin,
                         destination: destination,
                         depart: DateTime.current + 5.hours,
                         arrive: DateTime.current + 8.hours,
                         capacity: 100,
                         fare: 100.00)
  end
  
  test "should be valid" do
    assert @flight.valid?
  end
  
  test "origin should not be blank" do
    @flight.origin = nil
    assert_not @flight.valid?
  end
  
  test "capacity should be a positive number" do
    @flight.capacity = nil
    assert_not @flight.valid?
    @flight.capacity = 0
    assert_not @flight.valid?
    @flight.capacity = -2
    assert_not @flight.valid?
  end
  
  test "fare should be a number not less than zero" do
    @flight.fare = nil
    assert_not @flight.valid?
    @flight.fare = -1
    assert_not @flight.valid?
    @flight.fare = 0
    assert @flight.valid?
  end
  
  test "destination should not be blank" do
    @flight.destination = nil
    assert_not @flight.valid?
  end
  
  test "depart should not be blank" do
    @flight.depart = nil
    assert_not @flight.valid?
  end
  
  test "arrive should not be blank" do
    @flight.arrive = nil
    assert_not @flight.valid?
  end
  
  test "arrival time should be later than departure time" do
    @flight.depart = DateTime.current + 6.hours
    @flight.arrive = DateTime.current + 4.hours
    assert_not @flight.valid?
  end
end
