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
GameAnswer.destroy_all
puts "Cleaning QUESTIONS database..."
Question.destroy_all
GameQuestion.destroy_all
puts "Cleaning POLICY_PLANS database..."
YoungContributor.destroy_all
Goal.destroy_all
Timestep.destroy_all
PolicyPlanInstitution.destroy_all
PolicyPlan.destroy_all
puts "Cleaning POLICY_MAKINGS database..."
PolicyMakingInstitution.destroy_all
PolicyMaking.destroy_all
# puts "Cleaning AMBASSADORS database..."
# Ambassador.destroy_all
puts "Cleaning INSTITUIONS database..."
Institution.destroy_all
puts "Cleaning OPPORTUNITIES database..."
Opportunity.destroy_all
puts "Cleaning OPPORTUNITY_TYPES database..."
OpportunityType.destroy_all
puts "Cleaning ORGANISATIONS database..."
OrganisationCountry.destroy_all
OrganisationTopic.destroy_all
Organisation.destroy_all
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
    new_institution = Institution.new(country: new_country, name: Faker::Company.name, website_url: Faker::Internet.url, video_url: "https://www.youtube.com/embed/BUMyjwCMzSI", video_source: "EU Council", video_alt_text: "bla")
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
pm = PolicyMaking.new(country: Country.first, topic: Topic.first, video_url: "https://www.youtube.com/embed/BUMyjwCMzSI", video_source: "EU Council", content: Faker::Lorem.sentence(word_count: 50, supplemental: false, random_words_to_add: 10))
pm.save
pms.push(pm)
pm = PolicyMaking.new(country: Country.first, topic: Topic.second, video_url: "https://www.youtube.com/embed/BUMyjwCMzSI", video_source: "EU Council", content: Faker::Lorem.sentence(word_count: 50, supplemental: false, random_words_to_add: 10))
pm.save
pms.push(pm)
pm = PolicyMaking.new(country: Country.second, topic: Topic.first, video_url: "https://www.youtube.com/embed/BUMyjwCMzSI", video_source: "EU Council", content: Faker::Lorem.sentence(word_count: 50, supplemental: false, random_words_to_add: 10))
pm.save
pms.push(pm)
pm = PolicyMaking.new(country: Country.second, topic: Topic.second, video_url: "https://www.youtube.com/embed/BUMyjwCMzSI", video_source: "EU Council", content: Faker::Lorem.sentence(word_count: 50, supplemental: false, random_words_to_add: 10))
pm.save
pms.push(pm)
pm = PolicyMaking.new(country: Country.third, topic: Topic.first, video_url: "https://www.youtube.com/embed/BUMyjwCMzSI", video_source: "EU Council", content: Faker::Lorem.sentence(word_count: 50, supplemental: false, random_words_to_add: 10))
pm.save
pms.push(pm)
pm = PolicyMaking.new(country: Country.third, topic: Topic.second, video_url: "https://www.youtube.com/embed/BUMyjwCMzSI", video_source: "EU Council", content: Faker::Lorem.sentence(word_count: 50, supplemental: false, random_words_to_add: 10))
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

# --------------- POLICY PLANS ---------------

puts "Creating policy plans, time steps and gamebook..."
pps = []
PolicyMaking.where(topic: Topic.where(name:'Energy & Climate')).each do |pm|
  policy_plan = PolicyPlan.new(policy_making: pm, name: Faker::Movies::HarryPotter.character, short_description: "With 75\% of its GHG emissions coming from the energy sector, the EU has launched the European Green Deal in an effort to become the first climate-neutral continent by 2050.", content: "The Deal comprises multiple strategies towards reaching climate neutrality. With the goal of cleaner energies, it is focused on ensuring a secure energy supply, promoting renewables and increasing energy efficiency. The objectives of the Deal are legally binding through the Climate Law. Supplementary strategies, such as the Climate Pact, are formulated to ensure that all member states have equal access to knowledge to guide them towards a sustainable future.", video_url: "https://www.youtube.com/embed/BUMyjwCMzSI", video_source: "EU Council", strategy: false)
  policy_plan.save
  pps.push(policy_plan)
  (1..10).to_a.each do |i|
    Timestep.new(date: Faker::Date.between(from: '2014-09-23', to: '2016-09-25'), name: Faker::Movies::StarWars.character, description: Faker::Lorem.sentence(word_count: 50, supplemental: false, random_words_to_add: 10), policy_plan: policy_plan).save
    question = GameQuestion.new(date: Faker::Date.between(from: '2014-09-23', to: '2016-09-25'), policy_plan: policy_plan, name: Faker::Movies::StarWars.character, context: Faker::Lorem.sentence(word_count: 50, supplemental: false, random_words_to_add: 10), question: "#{Faker::GreekPhilosophers.quote}?")
    question.save
    GameAnswer.new(game_question: question, answer: Faker::Movies::HarryPotter.quote, explanation: Faker::Movies::Ghostbusters.quote, right: true).save
    rand(2..4).times do
      GameAnswer.new(game_question: question, answer: Faker::Movies::HarryPotter.quote, explanation: Faker::Movies::Ghostbusters.quote, right: false).save
    end
  end
end
puts "#{PolicyPlan.count} policy plans with #{Timestep.count} time steps, #{Goal.count} goals, #{GameQuestion.count} gamebook questions and #{GameAnswer.count} answers created! \n\n"

puts "Creating strategies, goals and quizzes..."
PolicyMaking.where(topic: Topic.where(name:'Youth')).each do |pm|
  policy_plan = PolicyPlan.new(policy_making: pm, name: Faker::Movies::HarryPotter.character, short_description: "With 75\% of its GHG emissions coming from the energy sector, the EU has launched the European Green Deal in an effort to become the first climate-neutral continent by 2050.", content: "The Deal comprises multiple strategies towards reaching climate neutrality. With the goal of cleaner energies, it is focused on ensuring a secure energy supply, promoting renewables and increasing energy efficiency. The objectives of the Deal are legally binding through the Climate Law. Supplementary strategies, such as the Climate Pact, are formulated to ensure that all member states have equal access to knowledge to guide them towards a sustainable future.", video_url: "https://www.youtube.com/embed/BUMyjwCMzSI", video_source: "EU Council", strategy: true)
  policy_plan.save
  pps.push(policy_plan)
  (1..10).to_a.each do |i|
    Goal.new(name: Faker::Movies::StarWars.character, description: Faker::Lorem.sentence(word_count: 50, supplemental: false, random_words_to_add: 10), policy_plan: policy_plan, order: i).save
    question = GameQuestion.new(policy_plan: policy_plan, name: Faker::Movies::StarWars.character, context: Faker::Lorem.sentence(word_count: 50, supplemental: false, random_words_to_add: 10), question: "#{Faker::GreekPhilosophers.quote}?", order: i)
    question.save
    GameAnswer.new(game_question: question, answer: Faker::Movies::HarryPotter.quote, explanation: Faker::Movies::Ghostbusters.quote, right: true).save
    rand(2..4).times do
      GameAnswer.new(game_question: question, answer: Faker::Movies::HarryPotter.quote, explanation: Faker::Movies::Ghostbusters.quote, right: false).save
    end
  end
end
puts "#{PolicyPlan.count} policy plans & strategies with #{Goal.count} goals, #{GameQuestion.count} gamebook questions and #{GameAnswer.count} answers in total! \n\n"

puts "Creating young contributors..."
pps.each do |pp|
  2.times do
    contributor = YoungContributor.new(policy_plan: pp, name: "Fridays for Future (FFF)", description: "FFF is a youth-led organised movement that started in August 2018. FFF activists have very strongly criticised the economic stimulus packages, the EU's agricultural reforms and the recent 'Fit for 55' package . Their mass protests have been crucial way for young people to enter the political sphere, and these movements continue to put pressure on  decision-makers, leading to improved communication between policymakers and youth.", website_url: "https://www.iedonline.eu/download/climate-crisis/Tenti_Duccio_IED-Climate-Paper_2019.pdf")
    file = URI.open("https://globalaccessibilitynews.com/files/2013/03/European-Commission-logo.png")
    contributor.logo.attach(io: file, filename: "logo.png", content_type: 'image/png')
    contributor.save
  end
end
puts "#{YoungContributor.count} young contributors created! \n\n"

puts "Associating institutions to policyplans..."
pps.each do |pp|
  institutions = Institution.where(country: pp.policy_making.country)
  institutions.each do |i|
    PolicyPlanInstitution.new(policy_plan: pp, institution: i, description: Faker::Lorem.sentence(word_count: 50, supplemental: false, random_words_to_add: 10)).save
  end
end
puts "#{PolicyPlanInstitution.count} policy_plan_institutions created! \n\n"

# --------------- VOLUNTEERS ---------------

puts "Creating volunteers..."
5.times do
  new_volunteer = Volunteer.new(name: Faker::Superhero.name, role: Faker::Superhero.power, linkedin_link:"")
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
  organisation_countries = Country.all.sample(rand(1..3))
  organisation_countries.each do |country|
    OrganisationCountry.create(organisation: organisation, country: country)
  end
  puts "#{OrganisationCountry.count} organisation_countries created!"

  topics = Topic.all.sample(rand(1..3))
  topics.each do |topic|
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
