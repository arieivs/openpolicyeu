# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'open-uri'
require 'csv'

csv_reading_options = { col_sep: ',', quote_char: '"', headers: :first_row }

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
puts "Cleaning VOLUNTEER POSITIONS database..."
VolunteerPosition.destroy_all
puts "Empty database \n\n"

# --------------- TOPICS ---------------

puts "Creating topics..."
TOPICS = [{name:'Energy & Climate', icon: 'fas fa-bolt', icon_color: 'yellow'},
          {name:'Youth', icon: 'fas fa-child', icon_color: 'blue'}]
TOPICS.each do |topic|
  Topic.new(name: topic[:name], icon: topic[:icon], icon_color: topic[:icon_color]).save
end
topics = Topic.all.order(:id)
puts "#{Topic.count} topics created! \n\n"

# ------- COUNTRIES -------

puts "Creating countries..."
COUNTRIES = [{name: 'European Union', flag_url: 'https://www.flags.co.uk/client/uploads/5/european-union.png'},
             {name: 'Germany', flag_url: 'https://2.bp.blogspot.com/-sq6_up5jZ4I/T-iZxEPPX6I/AAAAAAAAEk4/031CmrTmj4Y/s1600/Germany+Flag.jpg'},
             {name: 'Italy', flag_url: 'https://cdn.freelogovectors.net/wp-content/uploads/2012/05/italy-flag.jpg'},
             {name: 'Portugal', flag_url: 'https://www.bestcustomflags.com/wp-content/uploads/2016/06/portugal-flag.jpg'},
             {name: 'Slovenia', flag_url: 'https://i1.wp.com/worldflags.com/wp-content/uploads/Slovenia-flag.gif?fit=850%2C564'}]
COUNTRIES.each do |country|
  new_country = Country.new(name: country[:name])
  file = URI.open(country[:flag_url])
  new_country.flag.attach(io: file, filename: "flag.png", content_type: 'image/png')
  new_country.save
end
countries = Country.all.order(:id)
puts "#{Country.count} countries created! \n\n"

# ------- INSTITUTIONS -------

puts "Creating institutions..."
# index,country_index,country,name,logo,website_url,video_url,video_alt_text,video_source
CSV.foreach('db/initial_seeds/institutions.csv', csv_reading_options) do |row|
  new_institution = Institution.new(country: countries[row[1].to_i], name: row[3], website_url: row[5], video_url: row[6], video_source: row[8], video_alt_text: row[7])
  file = URI.open(row[4])
  new_institution.logo.attach(io: file, filename: "logo.png", content_type: 'image/png')
  new_institution.save
  puts "created institution #{new_institution.name} \n"
end
institutions = Institution.all.order(:id)
puts "#{Institution.count} institutions created! \n\n"

# --------------- POLICY MAKINGS ---------------

puts "Creating policymakings..."
# index,country_index,country,topic_index,topic,content,video_url,video_alt_text,video_source
CSV.foreach('db/initial_seeds/policy_makings.csv', csv_reading_options) do |row|
  PolicyMaking.new(country: countries[row[1].to_i], topic: topics[row[3].to_i], video_url: row[6], video_source: row[8], content: row[5]).save
end
policy_makings = PolicyMaking.all.order(:id)
puts "#{PolicyMaking.count} policymakings created! \n\n"

puts "Associating institutions to policymakings..."
# index,policy_making_index,policy_making,institution_index,institution,description
CSV.foreach('db/initial_seeds/policy_making_institutions.csv', csv_reading_options) do |row|
  puts "#{policy_makings[row[1].to_i]} #{institutions[row[3].to_i].name}"
  PolicyMakingInstitution.new(policy_making: policy_makings[row[1].to_i], institution: institutions[row[3].to_i], description: row[5]).save
end
puts "#{PolicyMakingInstitution.count} policymaking_institutions created! \n\n"

# ----------- QUESTIONS & ANSWERS ----------

puts "Creating questions and answers for policymakings..."
# index,policy_making_index,policy_making,scope,question
CSV.foreach('db/initial_seeds/questions.csv', csv_reading_options) do |row|
  Question.new(policy_making: policy_makings[row[1].to_i], scope: row[3], question: row[4]).save
end
questions = Question.all.order(:id)

# index,question_index,answer,explanation,right
CSV.foreach('db/initial_seeds/answers.csv', csv_reading_options) do |row|
  Answer.new(question: questions[row[1].to_i], answer: row[2], explanation: row[3], right: (row[4] == 'true')).save
end

puts "#{Question.count} questions and #{Answer.count} answers created! \n\n"

# --------------- POLICY PLANS ---------------

puts "Creating policy plans..."
# index,policy_making_index,policy_making,name,short_description,content,video_url,video_alt_text,video_source,goals
CSV.foreach('db/initial_seeds/policy_plans.csv', csv_reading_options) do |row|
  PolicyPlan.new(policy_making: policy_makings[row[1].to_i], name: row[3], short_description: row[4], content: row[5], video_url: row[6], video_source: row[8], goals: (row[9] == 'true')).save
end
policy_plans = PolicyPlan.all.order(:id)
puts "#{PolicyPlan.count} policy plans created! \n\n"

puts "Associating institutions to policyplans..."
# index,policy_plan_index,policy_plan,institution_index,institution,description
CSV.foreach('db/initial_seeds/policy_plan_institutions.csv', csv_reading_options) do |row|
  PolicyPlanInstitution.new(policy_plan: policy_plans[row[1].to_i], institution: institutions[row[3].to_i], description: row[5]).save
end
puts "#{PolicyPlanInstitution.count} policy_plan_institutions created! \n\n"

# --------------- TIMESTEPS & GOALS ---------------

puts "Creating time steps and goals..."
# index,policy_plan_index,policy_plan,day,month,year,name,description
CSV.foreach('db/initial_seeds/timesteps.csv', csv_reading_options) do |row|
  Timestep.new(date: Date.new(row[5].to_i, row[4].to_i, row[3].to_i), name: row[6], description: row[7], policy_plan: policy_plans[row[1].to_i]).save
end

# index,policy_plan_index,policy_plan,name,description,order
CSV.foreach('db/initial_seeds/goals.csv', csv_reading_options) do |row|
  Goal.new(name: row[3], description: row[4], policy_plan: policy_plans[row[1].to_i], order: row[5].to_i).save
end
puts "#{Timestep.count} time steps and #{Goal.count} goals created! \n\n"

# -------- GAMEQUESTIONS & GAMEANSWERS ---------

puts "Creating gamebook..."
# index,policy_plan_index,policy_plan,day,month,year,order,name,context,question
CSV.foreach('db/initial_seeds/game_questions.csv', csv_reading_options) do |row|
  if row[6].nil? # if there's no order
    GameQuestion.new(date: Date.new(row[5].to_i, row[4].to_i, row[3].to_i), policy_plan: policy_plans[row[1].to_i], name: row[7], context: row[8], question: row[9]).save
  else
    GameQuestion.new(order: row[6].to_i, policy_plan: policy_plans[row[1].to_i], name: row[7], context: row[8], question: row[9]).save
  end
end
game_questions = GameQuestion.all.order(:id)

# index,game_question_index,answer,explanation,right
CSV.foreach('db/initial_seeds/game_answers.csv', csv_reading_options) do |row|
  GameAnswer.new(game_question: game_questions[row[1].to_i], answer: row[2], explanation: row[3], right: (row[4] == 'true')).save
end
puts "#{GameQuestion.count} gamebook questions and #{GameAnswer.count} answers created! \n\n"

# -------- YOUNG CONTRIBUTORS ---------

puts "Creating young contributors..."
# index,policy_plan_index,policy_plan,name,description,website_url,logo
CSV.foreach('db/initial_seeds/young_contributors.csv', csv_reading_options) do |row|
  new_contributor = YoungContributor.new(policy_plan: policy_plans[row[1].to_i], name: row[3], description: row[4], website_url: row[5])
  file = URI.open(row[6])
  new_contributor.logo.attach(io: file, filename: "logo.png", content_type: 'image/png')
  new_contributor.save
  puts "created young contributor #{new_contributor.name} \n"
end
puts "#{YoungContributor.count} young contributors created! \n\n"

# --------------- ORGANISATIONS ---------------

puts "Creating organisations..."
# index,name,description,learn_more_link,logo
CSV.foreach('db/initial_seeds/organisations.csv', csv_reading_options) do |row|
  new_organisation = Organisation.new(name: row[1], description: row[2], learn_more_link: row[3])
  file = URI.open(row[4])
  new_organisation.logo.attach(io: file, filename: "logo.png", content_type: 'image/png')
  new_organisation.save
  puts "created organisation #{new_organisation.name} \n"
end
organisations = Organisation.all.order(:id)
puts "#{Organisation.count} organisations created! \n\n"

puts "Associating countries and topics to organisations..."
# index,country_index,country,organisation_index,organisation
CSV.foreach('db/initial_seeds/organisation_countries.csv', csv_reading_options) do |row|
  OrganisationCountry.create(organisation: organisations[row[3].to_i], country: countries[row[1].to_i])
end

# index,topic_index,topic,organisation_index,organisation
CSV.foreach('db/initial_seeds/organisation_topics.csv', csv_reading_options) do |row|
  OrganisationTopic.create(organisation: organisations[row[3].to_i], topic: topics[row[1].to_i])
end
puts "#{OrganisationCountry.count} organisation_countries and #{OrganisationTopic.count} organisation_topics created!"

# Later for Opportunitties:
# OPPORTUNITY_TYPES = ['Job', 'Volunteer', 'Internship']
# OPPORTUNITY_TYPES.each { |opp| OpportunityType.create(name: opp) }
# puts "#{Opportunity.count} opportunities created!"

# --------------- VOLUNTEERS ---------------

puts "Creating volunteers..."
# index,name,role,linkedin_link,photo
CSV.foreach('db/initial_seeds/volunteers.csv', csv_reading_options) do |row|
  new_volunteer = Volunteer.new(name: row[1], role: row[2], linkedin_link:row[3])
  file = URI.open(row[4])
  new_volunteer.photo.attach(io: file, filename: "profilepic.png", content_type: 'image/png')
  new_volunteer.save
  puts "created volunteer #{new_volunteer.name} \n"
end
puts "#{Volunteer.count} volunteers created! \n\n"

# --------- VOLUNTEER POSITIONS ------------

puts "Creating volunteering positions..."
# index,team,name,description,requirements
CSV.foreach('db/initial_seeds/volunteer_positions.csv', csv_reading_options) do |row|
  VolunteerPosition.new(team: row[1], name: row[2], description: row[3], requirements:row[4], how_to_apply: row[5]).save
end
puts "#{VolunteerPosition.count} volunteering positions created! \n\n"

puts 'Done :)'
