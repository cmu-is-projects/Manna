# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
User.create(first_name: 'Heidi', last_name: 'Dekkon', email: 'head_deacon@gmail.com', password: 'meh', phone: '4124788458', role: 'head_deacon')
User.create(first_name: 'Jason', last_name: 'Chen', email: 'jason95014@gmail.com', password: 'meh', phone: '4124788458', role: 'admin')
User.create(first_name: 'Johnny', last_name: 'Wu', email: 'jwu@gmail.com', password: 'meh', phone: '4124788458', role: 'care deacon')
User.create(first_name: 'Justin', last_name: 'Chen', email: 'jchen@gmail.com', password: 'meh', phone: '4124788458', role: 'financial deacon')
User.create(first_name: 'Kane', last_name: 'Manage', email: 'staff@gmail.com', password: 'meh', phone: '4124788458', role: 'staff')
