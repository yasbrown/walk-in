require "faker"
require "date"
require "open-uri"
require "nokogiri"
# # This file should contain all the record creation needed to seed the database with its default values.
# # The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

url = "https://www.timeout.com/london/restaurants/best-restaurants-in-london"
html = URI.open(url).read
doc = Nokogiri::HTML(html)

restaurants_names = doc.search(".articleContent h3")
restautants_description = doc.search("._summary_1p2xe_21 p")
restaurants_cuisines = doc.search("._text_163gl_28").xpath('//ul/li[position()=2]')

# *-- RETURNS RESTAURANT NAME --*
names_array = []
restaurants_names.take(20).each do |restaurants_name|
  names = restaurants_name.text.strip.split(/\d+.\W/)
  names_array << names[1]
end
# p names_array

# *-- RETURNS RESTAURANT CUISINE --*
cuisine_array = []
restaurants_cuisines.take(28).each do |restaurants_cuisine|
  cuisine_array << restaurants_cuisine.text.strip
end
cuisine_array = cuisine_array.slice(8..-1)
# p cuisine_array

# *-- RETURNS RESTAURANT DESCRIPTION --*
description_array = []
restautants_description.take(60).each do |description|
  description = description.text.strip.split(/\AWhat\Ss\sthe\sdeal\S\s/)
  description_array << description[1]
end
description_array = description_array.reject { |element| element == nil }
# p description_array

# *-- RETURNS POSTCODE --*
address_array = []
names_array.each do |name|
  if name.include?("Quality")
    restaurants_urls = "https://www.timeout.com/london/bars-and-pubs/quality-wines-farringdon"
  elsif name.include?("Sessions")
    restaurants_urls = "https://www.timeout.com/london/restaurants/sessions-arts-club"
  elsif name.include?("Sambal")
    restaurants_urls = "https://www.timeout.com/london/restaurants/sambal-shiok"
  elsif name.include?("Roti")
    restaurants_urls = "https://www.timeout.com/london/restaurants/roti-king"
  elsif name.include?("Café")
    restaurants_urls = "https://www.timeout.com/london/restaurants/cafe-cecilia"
  elsif name.include?("Rochelle")
    restaurants_urls = "https://www.timeout.com/london/restaurants/rochelle-canteen"
  elsif name.include?("Noble")
    restaurants_urls = "https://www.timeout.com/london/restaurants/noble-rot"
  elsif name.include?("Sonora")
    restaurants_urls = "https://www.timeout.com/london/restaurants/noble-rot"
  elsif name.include?("Mangal")
    restaurants_urls = "https://www.timeout.com/london/restaurants/mangal-2"
  elsif name.include?("Tofu")
    restaurants_urls = "https://www.timeout.com/london/restaurants/tofu-vegan"
  elsif name.include?("St")
    hyphen_name = name.gsub!(/\s/, '-')
    restaurants_urls = "https://www.timeout.com/london/restaurants/#{hyphen_name}"
  else
    restaurants_urls = "https://www.timeout.com/london/restaurants/#{name}"
  end

  restaurant_array = []
  postcode_array = []
  restaurant_show_html = URI.open(restaurants_urls).read
  restaurant_doc = Nokogiri::HTML(restaurant_show_html)

  details = restaurant_doc.search("._list_1fhdc_5")
  details.each do |restaurant_details|
    details = restaurant_details.text.strip.split(/(Address:)|(London)/)
    street = details[2]
    city = details[3]
    postcode = details[4]
    address = "#{street}, #{city}, #{postcode}"
    restaurant_array << address
  end
  address_array << restaurant_array[0]
end
# p address_array

# *-- REVIEWS --*
review_content = ["Dinner was amazing! We got here around 9pm on a Tuesday night and the wait was over an hour. A little surprised by that but the time went by pretty quick. They brought out some lemonade while we were waiting which was nice. Food itself was great and the atmosphere is amazing as well",
                  "Amazing experience. Visited for a lunch for my birthday and the staff made it super special with attentive, helpful and genuine service. Looking forward to going back.",
                  "What a place!! Had breakfast here and absolutely loved it. Highly recommended!!",
                  "Lovely restaurant, nice crowd and delicious food. Will definitely come back soon!",
                  "Amazing food to share and good drink menu with creative cocktails and natural wine selection. Love the at atmosphere and super nice staff.",
                  "Lovely small place with a small and delicious, innovative menu. Great service, much love goes into the food."]

# *-- IMAGES --*
restaurant_image = ["https://media.timeout.com/images/105881562/750/562/image.jpg",
                    "https://media.timeout.com/images/105248100/750/562/image.jpg",
                    "https://media.timeout.com/images/105881566/750/562/image.jpg",
                    "https://media.timeout.com/images/105881569/750/562/image.jpg",
                    "https://media.timeout.com/images/105881573/750/562/image.jpg",
                    "https://media.timeout.com/images/105881576/750/562/image.jpg",
                    "https://media.timeout.com/images/105881578/750/562/image.jpg",
                    "https://media.timeout.com/images/105881582/750/562/image.jpg",
                    "https://media.timeout.com/images/105881586/750/562/image.jpg",
                    "https://media.timeout.com/images/105881587/750/562/image.jpg",
                    "https://media.timeout.com/images/105881588/750/562/image.jpg",
                    "https://media.timeout.com/images/105881589/750/562/image.jpg",
                    "https://media.timeout.com/images/105881591/750/562/image.jpg",
                    "https://media.timeout.com/images/105881593/750/562/image.jpg",
                    "https://media.timeout.com/images/105881594/750/562/image.jpg",
                    "https://media.timeout.com/images/105881596/750/562/image.jpg",
                    "https://media.timeout.com/images/105884641/750/562/image.jpg",
                    "https://media.timeout.com/images/105905611/750/562/image.jpg",
                    "https://media.timeout.com/images/105881599/750/562/image.jpg",
                    "https://media.timeout.com/images/105881603/750/562/image.jpg"]
# # p "#{restaurant_image.sample}"

# *-- BUILDING INSTANCES --*
puts "Deleting all Users"
User.destroy_all
puts "Deleting all Restaurants"
Restaurant.destroy_all
puts "Deleting all Reviews"
Review.destroy_all
puts "Deleting all Covers"
Cover.destroy_all
puts "Deleting all Slots"
Slot.destroy_all
puts "Deleting all Restaurants"
Restaurant.destroy_all
puts "DB clean"

puts "Building new users"
users = []
10.times do
  user = User.create!(
    name: Faker::Name.name,
    email: Faker::Internet.email,
    password: "123456"
  )
  puts "User with id: #{user.id} has been created"
  users << user
end

puts "Building new restaurants"
names_array.each_with_index do |value, index|
  # result = Geocoder.search("se22 9lq")
  # address = result.first.display_name

  restaurant = Restaurant.create!(
    name: value,
    rating: rand(3.0...5.0).round(1),
    cuisine: cuisine_array[index],
    description: description_array[index],
    address: address_array[index],
    price: rand(1..3),
    opening_time: rand(9..11),
    closing_time: rand(23..24),
    date: Date.new(2022, 12, 9),
    total_seats_available: rand(100..150)
  )
  file = URI.open(restaurant_image[index])
  # file = URI.open("https://images.unsplash.com/photo-1517248135467-4c7edcad34c4?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8cmVzdGF1cmFudHxlbnwwfHwwfHw%3D&w=1000&q=80")
  restaurant.photo.attach(io: file, filename: "restaurant.png", content_type: "image/png")
  restaurant.save

  puts "Restaurant with id: #{restaurant.id} has been created"

  4.times do
    review = Review.create!(
      content: review_content.sample,
      restaurant: restaurant,
      user: users.sample
    )
    puts "Review with id: #{review.id} has been created"
  end
  3.times do
    cover = Cover.new(
      seats: rand(2..8)
    )
    cover.restaurant = restaurant
    cover.save!
    puts "Cover with id: #{cover.id} has been created"
    (restaurant.closing_time - restaurant.opening_time).times do |hour|
      slot = Slot.create!(
        date: Date.new(2022,12,9),
        available?: Faker::Boolean.boolean,
        start_time: restaurant.opening_time + hour,
        end_time: restaurant.opening_time + hour + 1,
        cover: cover
      )
      puts "Slot with id: #{slot.id} has been created"
    end
  end
end


puts "Finished!"


# *-- SEED FOR TESTING--*
# restaurant1 = Restaurant.new(
#   name: "only",
#   rating: 4,
#   cuisine: "Thai",
#   description: "description",
#   address: "Hackney",
#   price: rand(1..3),
#   opening_time: rand(9..11),
#   closing_time: rand(23..24),
#   date: Date.new(2022, 12, 9),
#   total_seats_available: rand(100..150)
# )

# file = URI.open("https://images.unsplash.com/photo-1517248135467-4c7edcad34c4?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8cmVzdGF1cmFudHxlbnwwfHwwfHw%3D&w=1000&q=80")
# restaurant1.photo.attach(io: file, filename: "restaurant.png", content_type: "image/png")
# restaurant1.save!

# cover1 = Cover.new(
#   seats: 2
# )
# cover1.restaurant = restaurant1
# cover1.save!

# slot1 = Slot.create!(
#   date: Date.new(2022, 12, 9),
#   available?: true,
#   start_time: 18,
#   end_time: 19,
#   cover: cover1
# )

# slot1.save!

# slot2 = Slot.create!(
#   date: Date.new(2022, 12, 9),
#   available?: false,
#   start_time: 21,
#   end_time: 22,
#   cover: cover1
# )

# slot2.save!

# restaurant2 = Restaurant.new(
#   name: "only",
#   rating: 1,
#   cuisine: "French",
#   description: "description",
#   address: "Islington",
#   price: rand(1..3),
#   opening_time: rand(9..11),
#   closing_time: rand(23..24),
#   date: Date.new(2022, 12, 9),
#   total_seats_available: rand(100..150)
# )

# file = URI.open("https://images.unsplash.com/photo-1517248135467-4c7edcad34c4?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8cmVzdGF1cmFudHxlbnwwfHwwfHw%3D&w=1000&q=80")
# restaurant2.photo.attach(io: file, filename: "restaurant.png", content_type: "image/png")
# restaurant2.save!

# cover2 = Cover.new(
#   seats: 4
# )
# cover2.restaurant = restaurant2
# cover2.save!

# slot3 = Slot.create!(
#   date: Date.new(2022, 12, 9),
#   available?: true,
#   start_time: 19,
#   end_time: 21,
#   cover: cover2
# )

# slot3.save!

# slot4 = Slot.create!(
#   date: Date.new(2022, 12, 9),
#   available?: false,
#   start_time: 20,
#   end_time: 22,
#   cover: cover1
# )

# slot4.save!
