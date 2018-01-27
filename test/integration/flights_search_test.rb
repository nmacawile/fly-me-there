require 'test_helper'

class FlightsSearchTest < ActionDispatch::IntegrationTest
  test "should be paginated with 10 results per page" do
    get flights_path
    assert_select "tr.booking-row", 10
  end
  
  test "should return unfiltered results when there are no parameters sorted by creation time in descending order" do
    get flights_path
    ("AAA".."AAT").each_slice(2) do |a, b|
      assert_select "tr.booking-row > td", { text: %r(#{a}\s+#{b}), count: 1 }
    end
    assert_select "tr.booking-row > td", { text: %r(FOO\s+BAZ), count: 0 }
    assert_select "tr.booking-row > td", { text: %r(BAZ\s+FOO), count: 0 }
  end
  
  test "should return only all flights from specified origin when origin parameter is present but destination is blank" do
    get flights_path, params: { origin: "FOO" }
    assert_select "tr.booking-row", 4
    assert_select "tr.booking-row > td", { text: %r(FOO\s+BAZ), count: 3 }
    assert_select "tr.booking-row > td", %r(FOO\s+AIR)
  end
  
  test "should return only all flights to specified destination when destination parameter is present but origin is blank" do
    get flights_path, params: { destination: "FOO" }
    assert_select "tr.booking-row", 2
    assert_select "tr.booking-row > td", %r(AIR\s+FOO)
    assert_select "tr.booking-row > td", %r(BAZ\s+FOO)
  end
  
  test "should return only flights from the specified origin to specified destination when both parameters have a value" do
    get flights_path, params: { origin: "FOO", destination: "BAZ" }
    assert_select "tr.booking-row", 3
    assert_select "tr.booking-row > td", { text: %r(FOO\s+BAZ), count: 3 }
  end
  
  test "should return only flights departing on the specified date if departure parameter has a value" do
    get flights_path, params: { origin: "FOO", destination: "BAZ", depart: "01/05/2018" }
    assert_select "tr.booking-row", 2
    assert_select "tr.booking-row > td", { text: %r(FOO\s+BAZ), count: 2 }
  end
  
  test "should return flights that have enough available seats when seats parameter has a value" do
    get flights_path, params: { origin: "FOO", destination: "BAZ", seats: 4 }
    assert_select "tr.booking-row", 2
    assert_select "tr.booking-row > td", { text: %r(FOO\s+BAZ), count: 2 }
  end
  
  test "should return all flights from specified origin country to destination country" do
    get flights_path, params: { origin: "UT", destination: "AT" }
    assert_select "tr.booking-row", 9
    assert_select "tr.booking-row > td", { text: %r(UTA\s+ATA), count: 1 }
    assert_select "tr.booking-row > td", { text: %r(UTB\s+ATB), count: 1 }
    assert_select "tr.booking-row > td", { text: %r(UTC\s+ATC), count: 1 }
    assert_select "tr.booking-row > td", { text: %r(UTD\s+ATD), count: 1 }
    assert_select "tr.booking-row > td", { text: %r(UTE\s+ATE), count: 1 }
    assert_select "tr.booking-row > td", { text: %r(UTB\s+ATA), count: 1 }
    assert_select "tr.booking-row > td", { text: %r(UTC\s+ATA), count: 1 }
    assert_select "tr.booking-row > td", { text: %r(UTA\s+ATB), count: 1 }
    assert_select "tr.booking-row > td", { text: %r(UTA\s+ATC), count: 1 }
  end
  
  test "should return all flights from specified origin country to destination airport" do
    get flights_path, params: { origin: "UT", destination: "ATA" }
    assert_select "tr.booking-row", 3
    assert_select "tr.booking-row > td", { text: %r(UTA\s+ATA), count: 1 }
    assert_select "tr.booking-row > td", { text: %r(UTB\s+ATA), count: 1 }
    assert_select "tr.booking-row > td", { text: %r(UTC\s+ATA), count: 1 }
  end
  
  test "should return all flights from specified origin airport to destination country" do
    get flights_path, params: { origin: "UTA", destination: "AT" }
    assert_select "tr.booking-row", 3
    assert_select "tr.booking-row > td", { text: %r(UTA\s+ATA), count: 1 }
    assert_select "tr.booking-row > td", { text: %r(UTA\s+ATB), count: 1 }
    assert_select "tr.booking-row > td", { text: %r(UTA\s+ATC), count: 1 }
  end
  
  test "should return all flights coming from specified origin country" do
    get flights_path, params: { origin: "UT" }
    assert_select "tr.booking-row", 10
    assert_select "tr.booking-row > td", { text: %r(UTD\s+DYS), count: 1 }
  end
  
  test "should return all flights leaving to specified destination country" do
    get flights_path, params: { destination: "AT" }
    assert_select "tr.booking-row", 10
    assert_select "tr.booking-row > td", { text: %r(DYS\s+ATD), count: 1 }
  end
end
