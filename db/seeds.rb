require 'csv'

#====================================================================

CSV.foreach("./data/countries.csv", headers: true) do |row|
  country = row.to_h
  Country.create!(name: country["name"],
                  iso: country["iso"])
end

#====================================================================

CSV.foreach("./data/airports.csv", headers: true) do |row|
  airport = row.to_h
  Airport.create!(name: airport["name"],
                  iata: airport["iata"],
                  municipality: airport["municipality"],
                  country: Country.find_by(name: airport["country"]))
end

#====================================================================

1000.times do
  origin, destination = Airport.joins(:country).where("countries.name" => "United States").order("RANDOM()").limit(2)
  depart_date = Faker::Date.forward(10)
  depart = depart_date + rand(4).hours
  arrive = depart + rand(2..6).hours
  capacity = rand(18..30) * 10
  fare = rand(200..500)

  flight = Flight.create!(origin: origin,
                   destination: destination,
                   depart: depart,
                   arrive: arrive,
                   capacity: capacity,
                   fare: fare)
                   
  Booking.create!(flight: flight)
end

#====================================================================

Booking.all.each do |booking|
  4.times do |n|
    Passenger.create!(name: Faker::Name.name,
                      email: "user#{n}@email.com",
                      booking: booking)
  end
end

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