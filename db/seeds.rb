# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Role.create([{name: "admin"},{name: "user"}])

admin_user = User.create(name: "admin",email: "admin@example.com",username: "admin", password: "admin",roles: [Role.admin])
user = User.create(name: "user",email: "user@example.com",username: "user", password: "user",roles: [Role.user])

store = Store.create(name: "fake store",address: 'fake address',user_id: user.id)

5.times do |i|
  Product.create(name: "Product#{i}",price: 100,store_id: store.id)
end