require "faker"
require "json"
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

puts "Deleting all Restaurants"
Restaurant.destroy_all
puts "DB clean"

puts "Building new restaurants"
150.times do
  restaurant = Restaurant.create(
    name: Faker::Restaurant.name,
    rating: rand(3.0...5.0),
    total_seats_available: rand(2..10),
    cuisine: Faker::Restaurant.type,
    description: Faker::Restaurant.description
  )
  puts "Restaurant with id: #{restaurant.id} has been created"
end

puts "Finished!"
