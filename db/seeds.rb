require 'csv'

#====================================================================

start = Time.now
print "Seeding countries..."
CSV.foreach("./data/countries.csv", headers: true) do |row|
  country = row.to_h
  Country.create!(name: country["name"],
                  iso: country["iso"])
end
puts "done."
puts "Duration: #{Time.now - start}"

#====================================================================

start = Time.now
print "Seeding airports..."
CSV.foreach("./data/airports.csv", headers: true) do |row|
  airport = row.to_h
  Airport.create!(name: airport["name"],
                  iata: airport["iata"],
                  municipality: airport["municipality"],
                  country: Country.find_by(name: airport["country"]))
end
puts "done."
puts "Duration: #{Time.now - start}"

#====================================================================

start = Time.now
print "Seeding US domestic flights..."
400.times do
  origin, destination = Airport.joins(:country).where("countries.name" => "United States").order("RANDOM()").limit(2)
  depart_date = DateTime.parse("05/02/2018") + rand(11).days
  depart = depart_date + rand(24).hours
  arrive = depart + rand(2..6).hours
  capacity = rand(18..30) * 10
  fare = rand(200..500)

  flight = Flight.create!(origin: origin,
                   destination: destination,
                   depart: depart,
                   arrive: arrive,
                   capacity: capacity,
                   fare: fare)
end
puts "done."
puts "Duration: #{Time.now - start}"


start = Time.now
print "Seeding flights..."
4000.times do
  origin, destination = Airport.order("RANDOM()").limit(2)
  depart_date = DateTime.parse("05/02/2018") + rand(11).days
  depart = depart_date + rand(24).hours
  arrive = depart + rand(2..6).hours
  capacity = rand(18..30) * 10
  fare = rand(200..500)

  flight = Flight.create!(origin: origin,
                   destination: destination,
                   depart: depart,
                   arrive: arrive,
                   capacity: capacity,
                   fare: fare)
end
puts "done."
puts "Duration: #{Time.now - start}"

#====================================================================

start = Time.now
print "Seeding bookings..."
Flight.order("RANDOM()").limit(200).each do |flight|
  booking = Booking.create!(flight: flight)
  4.times do |n|
    Passenger.create!(name: Faker::Name.name,
                      email: "user#{n}@email.com",
                      booking: booking)
  end
end
puts "done."
puts "Duration: #{Time.now - start}"

#====================================================================

flight = Flight.create!(origin: Airport.find(1),
                        destination: Airport.find(2),
                        depart: DateTime.now,
                        arrive: DateTime.now + 6.hours,
                        capacity: 3,
                        fare: 100.00)
                        
booking = Booking.create!(flight: flight)

Passenger.create!(name: Faker::Name.name,
                  email: "pass1@email.com",
                  booking: booking)
                  
Passenger.create!(name: Faker::Name.name,
                  email: "pass2@email.com",
                  booking: booking)                 