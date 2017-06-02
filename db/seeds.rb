# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
User.create(first_name: 'Jason', last_name: 'Chen', email: 'jason95014@gmail.com', password: 'meh', phone: '4089315510', role: 'admin')
User.create(first_name: 'Johnny', last_name: 'Wu', email: 'jwu@gmail.com', password: 'meh', phone: '4089315510', role: 'care deacon')
User.create(first_name: 'Justin', last_name: 'Chen', email: 'jchen@gmail.com', password: 'meh', phone: '4089315510', role: 'financial deacon')
