# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Product.destroy_all
User.destroy_all
Item.destroy_all
Basket.destroy_all
Review.destroy_all

Product.create([{
  name: 'Toilet Roll',
  description: '200 sheet, 2ply, economic 1 roll, for an action packed lockdown!',
  category: 'Toiletries',
  image_url: 'toiletroll.jpeg',
  price: '9.99',
  quantityInStock: '10',
  has_badge: true,
  is_new: false
},
{
  name: 'HX-12 Pro Laptop',
  description: 'For serious gamers who need serious performance using serious specs.',
  category: 'Technology',
  image_url: 'hx12laptop.jpeg',
  price: '699.99',
  quantityInStock: '2',
  has_badge: false,
  is_new: true
},
{
  name: 'Big Water Bottle',
  description: '10L Water Bottle with Mineral Water, filtered through 22 layers of volcanic rock! (Yes including the bottle).',
  category: 'Food & Drinks',
  image_url: 'bigwaterbottle.jpeg',
  price: '1.99',
  quantityInStock: '50',
  has_badge: false,
  is_new: false
},
{
  name: 'Super Battery Power Bank',
  description: '3000v Super Charger - instant battery for your phone.',
  category: 'Technology',
  image_url: 'batterypowerbank.jpeg',
  price: '12.99',
  quantityInStock: '7',
  has_badge: true,
  is_new: false
},
{
  name: 'Kitchen Gloves (Large)',
  description: 'These bad boys can withstand 10+ hours of scrubbing.',
  category: 'Kitchen',
  image_url: 'kitchenglove.jpeg',
  price: '3.99',
  quantityInStock: '36',
  has_badge: false,
  is_new: false
},
{
  name: 'Whamazone Backpack',
  description: 'Our official backpack!',
  category: 'Essentials',
  image_url: 'backpack.jpeg',
  price: '18.99',
  quantityInStock: '100',
  has_badge: true,
  is_new: true
}])

User.create([{
  id: 0,
  name: 'Whamazone Admin',
  username: 'Admin',
  email: 'Admin@Whamazone.com',
  password: 'WHAM',
  password_confirmation: 'WHAM'
},
{
  username: 'john',
  name: 'john s',
  email: 'mynameisjohn@mail.com',
  password: 'john',
  password_confirmation: 'john'
},
{
  username: 'Bradinator',
  name: 'Brad W',
  email: 'coolbrad@mail.com',
  password: 'bradisrad',
  password_confirmation: 'bradisrad'
},
{
  username: 'KayTee',
  name: 'Katie S',
  email: 'KT115@mail.com',
  password: 'mysupersecretpassword',
  password_confirmation: 'mysupersecretpassword'
},
{
  name: 'Tester',
  username: 'Test',
  email: 'test@mail.com',
  password: 'test',
  password_confirmation: 'test'
}])

Review.create([{
  product_id: 1,
  user_id: 1,
  title: 'THIS IS QUALITY',
  comment: 'DOES GREAT JOB!!!!!',
  rating: 5
},
{
  product_id: 1,
  user_id: 2,
  title: 'I can roll with this',
  comment: 'Quality product, does what it needs to do.',
  rating: 5
},
{
  product_id: 1,
  user_id: 3,
  title: 'Surprisingly good quality!',
  comment: 'Bought this because it was out of stock everywhere. Better than I expected!',
  rating: 5
},
{
  product_id: 3,
  user_id: 1,
  title: 'THIS WATER BOTTLE IS SO BIG!!!!',
  comment: 'CAN HOLD SO MUCH WATER!!!',
  rating: 5
},
{
  product_id: 3,
  user_id: 2,
  title: 'Destroyed a bear with this',
  comment: 'I was out doing my usual jogs in the forest when I suddenly got ambushed by a grizzly bear. I threw the bottle at it which made it slip down the hill, never felt so cool after that encounter.',
  rating: 5
},
{
  product_id: 3,
  user_id: 3,
  title: 'Big, cheap, and durable!',
  comment: 'Bought this for my morning jogs, has amazing grip even whilst running.',
  rating: 5
},
{
  product_id: 4,
  user_id: 2,
  title: 'My phone exploded after using this',
  comment: 'I was super skeptical about the description of this product but it charges my phone in 5 seconds. But I left it for 5 minutes because my wife was mad about something.',
  rating: 1
},
{
  product_id: 5,
  user_id: 3,
  title: 'Dissapointingly below average',
  comment: 'Gloves are a bit too large for my hands, it also started to break after 3 days of regular usage.',
  rating: 2
},
{
  product_id: 5,
  user_id: 1,
  title: 'GLOVES FIT MY LARGE HANDS',
  comment: 'AMAZING QUALITY',
  rating: 5
}])

p "Created #{Product.count} products"
p "Created #{User.count} users"
p "Created #{Review.count} reviews"
