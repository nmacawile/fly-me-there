require 'test_helper'

class AirportTest < ActiveSupport::TestCase
  def setup
    country = countries(:zab)
    @airport = Airport.new(name: "Example Airport",
                            iata: "EXA",
                            municipality: "Example City",
                            country: country)
  end
  
  test "should be valid" do
    assert @airport.valid?
  end
  
  test "name should not be blank" do
    @airport.name = ""
    assert_not @airport.valid?
  end
  
  test "iata should not be blank and must be unique" do
    @airport.iata = ""
    assert_not @airport.valid?
    @airport.iata = "FOO"
    assert_not @airport.valid?
  end
end
