require 'faker'
 
# Create Users
5.times do
  user = User.new(
    email:    Faker::Internet.email,
    password: Faker::Lorem.characters(10)
  )
  user.skip_confirmation!
  user.save!
end
users = User.all

# Create Apps
20.times do
  app = RegisteredApplication.create!(
    user:   users.sample,
    name:  Faker::Company.name,
    url:   Faker::Internet.domain_name
  )
end
registered_apps = RegisteredApplication.all

# Create Events
500.times do
  event = Event.create!(
    registered_application:   registered_apps.sample,
    name:  Faker::Hacker.ingverb
  )
end

# Create Custom User
user = User.first
user.skip_reconfirmation!
user.update_attributes!(
  email: 'klaha.77@gmail.com',
  password: 'helloworld'
)

puts "Seed finished"
puts "#{User.count} users created"
puts "#{RegisteredApplication.count} registered apps created"
puts "#{Event.count} events created"