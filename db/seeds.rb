require "faker"
require "date"
require "open-uri"
require "nokogiri"
# # This file should contain all the record creation needed to seed the database with its default values.
# # The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
# #
# # Examples:
# #
# #   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
# #   Character.create(name: "Luke", movie: movies.first)

url = "https://www.timeout.com/london/restaurants/best-restaurants-in-london"
html = URI.open(url).read
doc = Nokogiri::HTML(html)

restaurants_names = doc.search(".articleContent h3")
restautants_description = doc.search("._summary_1p2xe_21 p")
restaurants_cuisines = doc.search("._text_163gl_28")
restaurants_urls = doc.search("._title_1p2xe_9 a")
restaurant_url = restaurants_urls[0]["href"]

restaurant_show_html = URI.open(restaurant_url)
restaurant_doc = Nokogiri::HTML(restaurant_show_html)

# *-- RETURNS RESTAURANT NAME BUT WITH LEADING WHITESPACE --*
names_array = []
restaurants_names.take(20).each do |restaurants_name|
  names = restaurants_name.text.strip.split(/\d+.\W/)
  names_array << names[1]
end
# p names_array

# *-- RETURNS RESTAURANT CUISINE --*
cuisine_array = []
restaurants_cuisines.take(60).each do |restaurants_cuisine|
  cuisine_array << restaurants_cuisine.text.strip
end
# p cuisine_array

# *-- RETURNS RESTAURANT DESCRIPTION & PRICE --*
description_array = []
restautants_description.take(60).each do |description|
  description_array << description.text.strip
end
p description_array

# *-- RETURNS ADDRESS, POSTCODE, WEBSITE, TRANSPORT & MENU LINK --*
details_array =[]
details = restaurant_doc.search("._list_1fhdc_5 dd")
details.each do |detail|
  details_array << detail.text.strip
end
# p details_array[0]


# restaurant_image = ["https://res.cloudinary.com/dft14camn/image/upload/v1669898682/qiyikkxbiguukfrwtuch.jpg",
#                     "https://res.cloudinary.com/dft14camn/image/upload/v1669898677/hpxsndb6rciucmq0kiuq.jpg",
#                     "https://res.cloudinary.com/dft14camn/image/upload/v1669898671/cacoeek2ntmuqe3i5x3v.jpg",
#                     "https://res.cloudinary.com/dft14camn/image/upload/v1669898666/alxlfxstghhi55xycht8.jpg",
#                     "https://res.cloudinary.com/dft14camn/image/upload/v1669898661/qtdqa1ghq5r3dmf4do6z.jpg",
#                     "https://res.cloudinary.com/dft14camn/image/upload/v1669898655/zlzxlctdx0yjrdmjo3z6.jpg",
#                     "https://res.cloudinary.com/dft14camn/image/upload/v1669898648/ggaapk18xia1pqk60evb.jpg",
#                     "https://res.cloudinary.com/dft14camn/image/upload/v1669898494/bnp41fowfhejhrs3bvuf.jpg",
#                     "https://res.cloudinary.com/dft14camn/image/upload/v1669898489/eqcjggopzjvl6ovympx9.jpg",
#                     "https://res.cloudinary.com/dft14camn/image/upload/v1669898483/hmumlyeopzl6eanaxael.jpg",
#                     "https://res.cloudinary.com/dft14camn/image/upload/v1669898475/xwywbrswjemvkpxczhtt.jpg",
#                     "https://res.cloudinary.com/dft14camn/image/upload/v1669898469/uqgbcketz2e6ngnidmka.jpg",
#                     "https://res.cloudinary.com/dft14camn/image/upload/v1669898460/sriurkfemhiaem0vrspy.jpg",
#                     "https://res.cloudinary.com/dft14camn/image/upload/v1669898454/kwn9mcjc6bdpwo7l7mye.jpg",
#                     "https://res.cloudinary.com/dft14camn/image/upload/v1669898445/r977r8h4oimhwq4kturo.jpg",
#                     "https://res.cloudinary.com/dft14camn/image/upload/v1669898222/ayblljxpm6hjhcm2dd3g.jpg",
#                     "https://res.cloudinary.com/dft14camn/image/upload/v1669898216/dl0hpuugj3trirk1ygzt.jpg",
#                     "https://res.cloudinary.com/dft14camn/image/upload/v1669898208/dkrpwntoq1h7fwan41ep.jpg",
#                     "https://res.cloudinary.com/dft14camn/image/upload/v1669898202/x3orikt9ywvfren2kavp.jpg",
#                     "https://res.cloudinary.com/dft14camn/image/upload/v1669898183/qvuhve94u4qbfo6fqsyd.jpg",
#                     "https://res.cloudinary.com/dft14camn/image/upload/v1669894421/myprbssl7fbjgn0yeaim.jpg"]
# # p "#{restaurant_image.sample}"

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
20.times do
  result = Geocoder.search(postcode.sample)
  address = result.first.display_name
  n = 0
  c = 2

  restaurant = Restaurant.create!(
    name: names_array[n += 1],
    rating: rand(3.0...5.0).round(2),
    cuisine: cuisine_array[c += 3],
    description: Faker::Restaurant.description,
    address: address,
    price: rand(1..3),
    opening_time: rand(9..11),
    closing_time: rand(23..24),
    date: Date.new(2022, 12, 9),
    total_seats_available: rand(100..150)
  )
  file = URI.open("#{restaurant_image.sample}")
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
  8.times do
    cover = Cover.new(
      seats: rand(2..8)
    )
    cover.restaurant = restaurant
    cover.save!
    puts "Cover with id: #{cover.id} has been created"
    3.times do
      slot = Slot.create!(
        date: Date.new(2022,12,9),
        available?: Faker::Boolean.boolean,
        start_time: rand(18..20),
        end_time: rand(21..23),
        cover: cover
      )
      puts "Slot with id: #{slot.id} has been created"
    end
  end
end

puts "Finished!"
