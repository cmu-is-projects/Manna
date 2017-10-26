# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
User.create(first_name: 'Heidi', last_name: 'Dekkon', email: 'head_deacon@gmail.com', password: 'meh', phone: '9733074206', role: 'head_deacon')
User.create(first_name: 'Jason', last_name: 'Chen', email: 'jason95014@gmail.com', password: 'meh', phone: '9733074206', role: 'admin')
User.create(first_name: 'Johnny', last_name: 'Wu', email: 'jwu@gmail.com', password: 'meh', phone: '9733074206', role: 'care_deacon')
User.create(first_name: 'Justin', last_name: 'Chen', email: 'jchen@gmail.com', password: 'meh', phone: '9733074206', role: 'financial_deacon')
User.create(first_name: 'Kane', last_name: 'Manage', email: 'staff@gmail.com', password: 'meh', phone: '9733074206', role: 'staff')


6.times do
  Case.create({
    client_name: Faker::Name.name,
    client_first_name: Faker::Name.name,
    date_submitted: Faker::Date.between(1.year.ago, Date.current),
    summary: Faker::Lorem.paragraph(7),
    notes: Faker::Lorem.sentence(3),
    recommendation: Faker::Lorem.sentence(1),
    status: "submitted",
    deacon_id: 2,
    subject: Faker::Lorem.sentence(1),
    amount_requested: Faker::Commerce.price,
    amount_approved: Faker::Commerce.price
    })
end

3.times do
  Case.create({
    client_name: Faker::Name.name,
    client_first_name: Faker::Name.name,
    date_submitted: Faker::Date.between(1.year.ago, Date.current),
    summary: Faker::Lorem.paragraph(7),
    notes: Faker::Lorem.sentence(3),
    recommendation: Faker::Lorem.sentence(1),
    status: "approved",
    deacon_id: 2,
    subject: Faker::Lorem.sentence(1),
    amount_requested: Faker::Commerce.price,
    amount_approved: Faker::Commerce.price
    })
end