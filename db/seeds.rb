require "faker"
require "date"
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

postcode = %i[SW98FG W38QL SE186EQ NW29QN W30LG NW108GZ SW23AS N228XY N99HH E163DN N32AG W66SS NW34SD E49AN W52DL W27DG
              SE16AP SE280NW SW194NS SW100BP E174DQ E29ET NW106EU N179UZ N128SD E84FL SE207BL SW198EY SW129JL SW66QS
              N10AJ NW96AB N52RT SE137DU NW24EX E143TJ SE228SU NW95ES E130AP E201GA E96QE N135UJ E111BH N89LE SW22DP
              N178JA SE156NE E113JA NW35JP N14NN SW73NX N11SB NW51RN SW66SP N90FP N211HE SW195AS SE13RQ N128RW SE165SZ
              N146QN W51HW SE15EL E97QG NW31TP SW162XD E10NQ NW25RZ SE114RR NW110HS SW64HF NW11LT N154FX SE135AF N77JL
              N127NJ SW33LH SW120LA E18QW SW116AR SW184HA W106LW W73PQ SE163LU SW47EP N79RR N15NU NW71FR N77PL NW37RS
              NW72QP SE228LA SE279QY N52TL N225EP N166PT N43JJ N182XE SE12LY NW99JJ E18NF N65NW SE270RS E15RN SW151AP
              N99PE NW41LL E105GT SE171LP SE155FA SE231BT SW196EN W127JG NW87AB W73QH SE265BE E10RD SE116HT SE136DH
              W26DZ NW74RG SW46AJ N176JY E79PX W127FR N31JN N29BA NW67BW SE280EL SE57AZ SE193HE NW80RF E50BQ N179RW
              N160ER N195RP SW66XQ SE228DL N28JX NW25PJ N154FT N88RL W43HB SE18TN SW40DU SW155HH N212AT N29PS NW72PE
              SW97ET E140FF SE156BU SW62EW SW178JB SE29AP SW185JZ SW191TX N43DJ SE62HP NW88PQ]

review_content = ["Dinner was amazing! We got here around 9pm on a Tuesday night and the wait was over an hour. A little surprised by that but the time went by pretty quick. They brought out some lemonade while we were waiting which was nice. Food itself was great and the atmosphere is amazing as well",
                  "Amazing experience. Visited for a lunch for my birthday and the staff made it super special with attentive, helpful and genuine service. Looking forward to going back.",
                  "What a place!! Had breakfast here and absolutely loved it. Highly recommended!!",
                  "Lovely restaurant, nice crowd and delicious food. Will definitely come back soon!",
                  "Amazing food to share and good drink menu with creative cocktails and natural wine selection. Love the at atmosphere and super nice staff.",
                  "Lovely small place with a small and delicious, innovative menu. Great service, much love goes into the food."]

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

  restaurant = Restaurant.create!(
    name: Faker::Restaurant.name,
    rating: rand(3.0...5.0).round(2),
    cuisine: Faker::Restaurant.type,
    description: Faker::Restaurant.description,
    address: address,
    price: rand(1..3),
    opening_time: rand(9..11),
    closing_time: rand(23..24),
    date: Date.new(2022, 12, 9)
  )
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
