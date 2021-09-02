# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'open-uri'

# --------------- CLEANING ---------------

puts "Cleaning ANSWERS database..."
Answer.destroy_all
puts "Cleaning QUESTIONS database..."
Question.destroy_all
puts "Cleaning POLICY_MAKINGS database..."
PolicyMakingInstitution.destroy_all
PolicyMaking.destroy_all
# puts "Cleaning AMBASSADORS database..."
# Ambassador.destroy_all
puts "Cleaning INSTITUIONS database..."
Institution.destroy_all
puts "Cleaning COUNTRIES database..."
Country.destroy_all
puts "Cleaning TOPICS database..."
Topic.destroy_all
puts "Cleaning VOLUNTEERS database..."
Volunteer.destroy_all
puts "Empty database \n\n"

# --------------- TOPICS ---------------

puts "Creating topics..."
# TOPICS = ['Energy', 'Climate', 'Education', 'Health & food safety', 'Mobility', 'Interregional cooperation', 'Defense, Industry, Space']
TOPICS = ['Energy', 'Climate', 'Youth']
TOPICS.each do |topic|
  Topic.new(name: topic).save
end
puts "#{Topic.count} topics created! \n\n"

# ------- COUNTRIES & INSTITUTIONS -------

puts "Creating countries and institutions..."
# COUNTRIES = ['Europe', 'Austria', 'Belgium', 'Bulgaria', 'Croatia', 'Republic of Cyprus', 'Czech Republic', 'Denmark', 'Estonia', 'Finland', 'France', 'Germany', 'Greece', 'Hungary', 'Ireland', 'Italy', 'Latvia', 'Lithuania', 'Luxembourg', 'Malta', 'Netherlands', 'Poland', 'Portugal', 'Romania', 'Slovakia', 'Slovenia', 'Spain', 'Sweden']
COUNTRIES = ['Europe', 'Germany', 'Portugal', 'Italy', 'Slovenia']
COUNTRIES.each do |country|
  new_country = Country.new(name: country) # Add flags ?
  new_country.save
  3.times do
    new_institution = Institution.new(country: new_country, name: Faker::Company.name, website_url: Faker::Internet.url, video_url: "https://www.youtube.com/watch?v=BUMyjwCMzSI", video_source: "EU Council", video_alt_text: "bla")
    file = URI.open("https://globalaccessibilitynews.com/files/2013/03/European-Commission-logo.png")
    new_institution.logo.attach(io: file, filename: "profilepic.png", content_type: 'image/png')
    new_institution.save
  end
end
puts "#{Country.count} countries and #{Institution.count} institutions created! \n\n"

# --------------- AMBASSADORS ---------------

# puts "Creating ambassadors..."
# 5.times do
#   new_ambassador = Ambassador.new(name: Faker::Superhero.name, description: Faker::Superhero.power, social_profile_link:"")
#   file = URI.open("https://images.unsplash.com/photo-1438761681033-6461ffad8d80?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=750&q=80")
#   new_ambassador.photo.attach(io: file, filename: "profilepic.png", content_type: 'image/png')
#   new_ambassador.save
# end

# --------------- POLICY MAKINGS ---------------

puts "Creating policymakings..."
pms = []
pm = PolicyMaking.new(country: Country.first, topic: Topic.first, video_url: "https://www.youtube.com/watch?v=BUMyjwCMzSI", video_source: "EU Council", content: Faker::Lorem.sentence(word_count: 50, supplemental: false, random_words_to_add: 10))
pm.save
pms.push(pm)
pm = PolicyMaking.new(country: Country.first, topic: Topic.second, video_url: "https://www.youtube.com/watch?v=BUMyjwCMzSI", video_source: "EU Council", content: Faker::Lorem.sentence(word_count: 50, supplemental: false, random_words_to_add: 10))
pm.save
pms.push(pm)
pm = PolicyMaking.new(country: Country.first, topic: Topic.third, video_url: "https://www.youtube.com/watch?v=BUMyjwCMzSI", video_source: "EU Council", content: Faker::Lorem.sentence(word_count: 50, supplemental: false, random_words_to_add: 10))
pm.save
pms.push(pm)
pm = PolicyMaking.new(country: Country.second, topic: Topic.second, video_url: "https://www.youtube.com/watch?v=BUMyjwCMzSI", video_source: "EU Council", content: Faker::Lorem.sentence(word_count: 50, supplemental: false, random_words_to_add: 10))
pm.save
pms.push(pm)
pm = PolicyMaking.new(country: Country.second, topic: Topic.third, video_url: "https://www.youtube.com/watch?v=BUMyjwCMzSI", video_source: "EU Council", content: Faker::Lorem.sentence(word_count: 50, supplemental: false, random_words_to_add: 10))
pm.save
pms.push(pm)
pm = PolicyMaking.new(country: Country.third, topic: Topic.third, video_url: "https://www.youtube.com/watch?v=BUMyjwCMzSI", video_source: "EU Council", content: Faker::Lorem.sentence(word_count: 50, supplemental: false, random_words_to_add: 10))
pm.save
pms.push(pm)
puts "#{PolicyMaking.count} policymakings created! \n\n"

puts "Associating institutions to policymakings..."
pms.each do |pm|
  institutions = Institution.where(country: pm.country)
  institutions.each do |i|
    PolicyMakingInstitution.new(policy_making: pm, institution: i, description: Faker::Lorem.sentence(word_count: 50, supplemental: false, random_words_to_add: 10)).save
  end
end
puts "#{PolicyMakingInstitution.count} policymaking_institutions created! \n\n"

# ----------- QUESTIONS & ANSWERS ----------

puts "Creating questions and answers for policymakings..."
pms.each do |pm|
  content_question = Question.new(policy_making: pm, scope: 'content', question: "#{Faker::Quotes::Shakespeare.hamlet}?")
  content_question.save
  Answer.new(question: content_question, answer: Faker::TvShows::BojackHorseman.quote, explanation: Faker::Movies::HitchhikersGuideToTheGalaxy.quote, right: true).save
  rand(2..4).times do
    Answer.new(question: content_question, answer: Faker::TvShows::BojackHorseman.quote, explanation: Faker::Movies::HitchhikersGuideToTheGalaxy.quote, right: false).save
  end
  question_institution = Question.new(policy_making: pm, scope: 'institutions', question: "#{Faker::Quotes::Shakespeare.hamlet}?")
  question_institution.save
  Answer.new(question: question_institution, answer: Faker::TvShows::BojackHorseman.quote, explanation: Faker::Movies::HitchhikersGuideToTheGalaxy.quote, right: true).save
  rand(2..4).times do
    Answer.new(question: question_institution, answer: Faker::TvShows::BojackHorseman.quote, explanation: Faker::Movies::HitchhikersGuideToTheGalaxy.quote, right: false).save
  end
end
puts "#{Question.count} questions and #{Answer.count} answers created! \n\n"

# --------------- VOLUNTEERS ---------------

puts "Creating volunteers..."
5.times do
  new_volunteer = Volunteer.new(name: Faker::Superhero.name, role: Faker::Superhero.power, linked_link:"")
  file = URI.open("https://images.unsplash.com/photo-1438761681033-6461ffad8d80?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=750&q=80")
  new_volunteer.photo.attach(io: file, filename: "profilepic.png", content_type: 'image/png')
  new_volunteer.save
end
puts "#{Volunteer.count} volunteers created! \n\n"

puts 'Done :)'
