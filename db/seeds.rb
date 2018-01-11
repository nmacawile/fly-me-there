require 'csv'

#====================================================================

200.times do |n|
  User.create!(name: Faker::Name.name,
               email: "user#{n}@email.com")
end

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

50.times do
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
                   
  passengers = User.order("RANDOM()").limit(20)
  passengers.each do |passenger|
    Booking.create!(user: passenger,
                    flight: flight)
  end
end

#====================================================================
