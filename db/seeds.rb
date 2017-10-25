# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
cat1 = Cat.create(name: 'Fluffy', color: 'Orange')
cat2 = Cat.create(name: 'Johnny', color: 'Black')
cat3 = Cat.create(name: 'Cindy', color: 'Orange')
request1 = CatRentalRequest.create(cat_id: cat1.id,
  start_date: Date.yesterday, end_date: Date.tomorrow, status: 'APPROVED' )
request2 = CatRentalRequest.create(cat_id: cat1.id, start_date: Date.yesterday,
  end_date: Date.tomorrow)
request3 = CatRentalRequest.create(cat_id: cat2.id, start_date: Date.yesterday,
  end_date: Date.tomorrow)
