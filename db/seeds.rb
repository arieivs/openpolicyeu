# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'open-uri'


# --------------- COUNTRIES ---------------

puts "Cleaning COUNTRIES database..."
Country.destroy_all

puts "Creating countries..."
COUNTRIES = ['Europe', 'Austria', 'Belgium', 'Bulgaria', 'Croatia', 'Republic of Cyprus', 'Czech Republic', 'Denmark', 'Estonia', 'Finland', 'France', 'Germany', 'Greece', 'Hungary', 'Ireland', 'Italy', 'Latvia', 'Lithuania', 'Luxembourg', 'Malta', 'Netherlands', 'Poland', 'Portugal', 'Romania', 'Slovakia', 'Slovenia', 'Spain', 'Sweden']
COUNTRIES.each do |country|
  Country.new(name: country).save # Add flags ?
end
puts "#{Country.count} countries created! \n\n"

# --------------- TOPICS ---------------

puts "Cleaning TOPICS database..."
Topic.destroy_all

puts "Creating topics..."
TOPICS = ['Energy', 'Climate', 'Education', 'Health & food safety', 'Mobility', 'Interregional cooperation', 'Defense, Industry, Space']
TOPICS.each do |topic|
  Topic.new(name: topic).save
end
puts "#{Topic.count} topics created! \n\n"

# --------------- AMBASSADORS ---------------

puts "Cleaning AMBASSADORS database..."
Ambassador.destroy_all

puts "Creating ambassadors..."
5.times do
  new_ambassador = Ambassador.new(name: Faker::Superhero.name, description: Faker::Superhero.power, social_profile_link:"")
  file = URI.open("https://images.unsplash.com/photo-1438761681033-6461ffad8d80?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=750&q=80")
  new_ambassador.photo.attach(io: file, filename: "profilepic.png", content_type: 'image/png')
  new_ambassador.save
end
puts "#{Ambassador.count} ambassadors created! \n\n"

# --------------- POLICY MAKINGS ---------------

puts "Cleaning POLICY_MAKINGS database..."
PolicyMaking.destroy_all

puts "Creating policy makings..."
PolicyMaking.new(country_id: 1, topic_id: 1, ambassador_id: 1, content: "blah blah blah").save
PolicyMaking.new(country_id: 1, topic_id: 2, ambassador_id: 1, content: "blah blah blah").save
PolicyMaking.new(country_id: 1, topic_id: 3, ambassador_id: 2, content: "blah blah blah").save
PolicyMaking.new(country_id: 2, topic_id: 1, ambassador_id: 3, content: "blah blah blah").save
PolicyMaking.new(country_id: 3, topic_id: 1, ambassador_id: 4, content: "blah blah blah").save
PolicyMaking.new(country_id: 4, topic_id: 1, ambassador_id: 5, content: "blah blah blah").save
puts "#{PolicyMaking.count} policy makings created! \n\n"

# --------------- VOLUNTEERS ---------------

puts "Cleaning VOLUNTEERS database..."
Volunteer.destroy_all

puts "Creating volunteers..."
5.times do
  new_volunteer = Volunteer.new(name: Faker::Superhero.name, role: Faker::Superhero.power, linked_link:"")
  file = URI.open("https://images.unsplash.com/photo-1438761681033-6461ffad8d80?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=750&q=80")
  new_volunteer.photo.attach(io: file, filename: "profilepic.png", content_type: 'image/png')
  new_volunteer.save
end
puts "#{Volunteer.count} volunteers created! \n\n"

puts 'Done :)'
