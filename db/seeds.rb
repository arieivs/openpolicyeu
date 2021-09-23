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
puts "Cleaning OPPORTUNITY_TYPES database..."
OpportunityType.destroy_all
puts "Cleaning VOLUNTEERS database..."
Volunteer.destroy_all
puts "Cleaning ORGANISATIONS database..."
Organisation.destroy_all
puts "Cleaning ORGANISATION_COUNTRIES database..."
OrganisationCountry.destroy_all
puts "Cleaning ORGANISATIONS_TOPICS database..."
OrganisationTopic.destroy_all
puts "Cleaning OPPORTUNITIES database..."
Opportunity.destroy_all
puts "Empty database \n\n"


# --------------- TOPICS ---------------

puts "Creating topics..."
# TOPICS = ['Energy', 'Climate', 'Education', 'Health & food safety', 'Mobility', 'Interregional cooperation', 'Defense, Industry, Space']
TOPICS = [{name:'Energy & Climate', icon: 'fas fa-bolt', icon_color: 'yellow'},
          {name:'Youth', icon: 'fas fa-child', icon_color: 'blue'}]
TOPICS.each do |topic|
  Topic.new(name: topic[:name], icon: topic[:icon], icon_color: topic[:icon_color]).save
end
puts "#{Topic.count} topics created! \n\n"

# ------- COUNTRIES & INSTITUTIONS -------

puts "Creating countries and institutions..."
# COUNTRIES = ['Europe', 'Austria', 'Belgium', 'Bulgaria', 'Croatia', 'Republic of Cyprus', 'Czech Republic', 'Denmark', 'Estonia', 'Finland', 'France', 'Germany', 'Greece', 'Hungary', 'Ireland', 'Italy', 'Latvia', 'Lithuania', 'Luxembourg', 'Malta', 'Netherlands', 'Poland', 'Portugal', 'Romania', 'Slovakia', 'Slovenia', 'Spain', 'Sweden']
COUNTRIES = [{name: 'Europe', flag_url: 'https://www.flags.co.uk/client/uploads/5/european-union.png'},
             {name: 'Germany', flag_url: 'https://2.bp.blogspot.com/-sq6_up5jZ4I/T-iZxEPPX6I/AAAAAAAAEk4/031CmrTmj4Y/s1600/Germany+Flag.jpg'},
             {name: 'Portugal', flag_url: 'https://www.bestcustomflags.com/wp-content/uploads/2016/06/portugal-flag.jpg'},
             {name: 'Italy', flag_url: 'https://cdn.freelogovectors.net/wp-content/uploads/2012/05/italy-flag.jpg'},
             {name: 'Slovenia', flag_url: 'https://i1.wp.com/worldflags.com/wp-content/uploads/Slovenia-flag.gif?fit=850%2C564'}]
COUNTRIES.each do |country|
  new_country = Country.new(name: country[:name])
  file = URI.open(country[:flag_url])
  new_country.flag.attach(io: file, filename: "flag.png", content_type: 'image/png')
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
pm = PolicyMaking.new(country: Country.second, topic: Topic.first, video_url: "https://www.youtube.com/watch?v=BUMyjwCMzSI", video_source: "EU Council", content: Faker::Lorem.sentence(word_count: 50, supplemental: false, random_words_to_add: 10))
pm.save
pms.push(pm)
pm = PolicyMaking.new(country: Country.second, topic: Topic.second, video_url: "https://www.youtube.com/watch?v=BUMyjwCMzSI", video_source: "EU Council", content: Faker::Lorem.sentence(word_count: 50, supplemental: false, random_words_to_add: 10))
pm.save
pms.push(pm)
pm = PolicyMaking.new(country: Country.third, topic: Topic.first, video_url: "https://www.youtube.com/watch?v=BUMyjwCMzSI", video_source: "EU Council", content: Faker::Lorem.sentence(word_count: 50, supplemental: false, random_words_to_add: 10))
pm.save
pms.push(pm)
pm = PolicyMaking.new(country: Country.third, topic: Topic.second, video_url: "https://www.youtube.com/watch?v=BUMyjwCMzSI", video_source: "EU Council", content: Faker::Lorem.sentence(word_count: 50, supplemental: false, random_words_to_add: 10))
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

# --------------- ORGANISATIONS ---------------

puts "Creating organisations..."
5.times do
  new_organisation = Organisation.new(name: Faker::Company.name, description: Faker::Company.catch_phrase, learn_more_link: "http://youthenergy.eu")
  file = URI.open(Faker::Company.logo)
  new_organisation.logo.attach(io: file, filename: "logo.png", content_type: 'image/png')
  new_organisation.save
end
puts "#{Organisation.count} organisations created! \n\n"

puts "Associating countries, topics and opportunities to organisations..."
OPPORTUNITY_TYPES = ['job', 'volunteer']
OPPORTUNITY_TYPES.each { |opp| OpportunityType.create(name: opp) }

Organisation.all.each do |organisation|
  ORGANISATION_COUNTRIES = Country.all.sample(rand(1..3))
  ORGANISATION_COUNTRIES.each do |country|
    OrganisationCountry.create(organisation: organisation, country: country)
  end
  puts "#{OrganisationCountry.count} organisation_countries created!"

  TOPICS = Topic.all.sample(rand(1..3))
  TOPICS.each do |topic|
    OrganisationTopic.create(organisation: organisation, topic: topic)
  end
  puts "#{OrganisationTopic.count} organisation_topics created!"

  nb_of_opportunities = rand(1..3)
  nb_of_opportunities.times do
    Opportunity.create(organisation: organisation, opportunity_type: OpportunityType.all.sample)
  end
  puts "#{Opportunity.count} opportunities created!"
end

puts 'Done :)'
