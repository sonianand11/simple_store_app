# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

p 'Populating roles'

['admin','user'].each do |name|
  Role.find_or_create_by(name: name)
end

p 'Populating admin user'
admin_user = User.find_or_create_by(email: 'admin@example.com') do |u|
  u.name= 'admin'
  u.username= 'admin'
  u.password = 'admin'
  u.roles =  [Role.admin]
end

p 'Populating user'
user = User.find_or_create_by(email: 'user@example.com') do |u|
  u.name= 'user'
  u.username= 'user'
  u.password = 'user'
  u.roles =  [Role.user]
end

p 'Populating store'
store = Store.first_or_create(user_id: user.id) do |s|
  s.name= 'fake store'
  s.address = 'fake address'
end

p 'Populating products'
5.times do |i|
  Product.create(name: "Product#{i}",price: 100,store_id: store.id)
end