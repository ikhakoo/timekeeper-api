# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

users = ["John", "Mike", "Jill", "Mary", "Mark"]
users.each do |user| 
	t = TimeCard.create!(username: user, occurrence: Date.today)
	t.time_entries.create!(time: Time.now)
end