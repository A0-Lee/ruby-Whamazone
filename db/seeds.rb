# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Product.destroy_all

Product.create([{
  name: 'Toilet Roll',
  description: '200 sheet, 2ply, economic 36 pack, for an action packed lockdown!',
  category: 'Toiletries',
  image_url: 'toiletroll.jpeg',
  price: '9.99',
  quantityInStock: '10'
},
{
  name: 'HX-12 Pro Laptop',
  description: 'For serious gamers who need serious performance using serious specs.',
  category: 'Technology',
  image_url: 'hx12laptop.jpeg',
  price: '699.99',
  quantityInStock: '2'
},
{
  name: 'Big Water Bottle',
  description: '10L Water Botle, filtered through 22 layers of volcanic rock! (Yes including the bottle).',
  category: 'Food & Drinks',
  image_url: 'bigwaterbottle.jpeg',
  price: '1.99',
  quantityInStock: '50'
},
{
  name: 'Super Battery Power Bank',
  description: '3000v Super Charger - instant battery for your phone.',
  category: 'Technology',
  image_url: 'batterypowerbank.jpeg',
  price: '12.99',
  quantityInStock: '7'
},
{
  name: 'Kitchen Gloves (Large)',
  description: 'These bad boys can withstand 10+ hours of scrubbing.',
  category: 'Kitchen',
  image_url: 'kitchenglove.jpeg',
  price: '3.99',
  quantityInStock: '36'
},
{
  name: 'Whamazone Backpack',
  description: 'Our official backpack!',
  category: 'Essentials',
  image_url: 'backpack.jpeg',
  price: '18.99',
  quantityInStock: '100'
}])

p "Created #{Product.count} products"
