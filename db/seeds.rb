# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
require 'random_data'

# create users
5.times do
  User.create!(
    # Using wishful coding to add random data
    name: RandomData.random_name,
    email: RandomData.random_email,
    password: RandomData.random_sentence
  )
end
users =  User.all

# create topics
15.times do
  Topic.create!(
    name:           RandomData.random_sentence,
    description:    RandomData.random_paragraph
  )
end
topics = Topic.all

#create posts
50.times do

  #use create with a band (!) to raise an error if there's a problem
  post = Post.create!(

    # use methods from a class that doesn't exist yet, RandomData
    # that will create random strings for title and body
    # wishful coding = writing code for classes and methods that don't
    # exist because it keeps you focused and saves time
    user:   users.sample,
    topic:  topics.sample,
    title:  RandomData.random_sentence,
    body:   RandomData.random_paragraph
    )

  # update the time a post was created which
  # makes seeded data more realistic
  # allows ranking algorithm in action later
  post.update_attribute(:created_at, rand(10.minutes .. 1.year).ago)
  # create between one and five votes for each post
  # [-1, 1].sample randomly creates a up or down vote
  rand(1..5).times { post.votes.create!(value: [-1, 1].sample, user: users.sample) }
end
posts = Post.all

# Create Comments
100.times do
  Comment.create!(
    user: users.sample,
    post: posts.sample,
    body: RandomData.random_paragraph
  )
end

# Create an admin user
admin = User.create!(
  name:     'Admin User',
  email:    'admin@example.com',
  password: 'helloworld',
  role:     'admin'
)

# Create a member
member = User.create!(
  name:     'Member User',
  email:    'member@example.com',
  password: 'helloworld'
)

puts "Seed finished"
puts "#{User.count} users created"
puts "#{Topic.count} topics created"
puts "#{Post.count} posts created"
puts "#{Comment.count} comments created"
puts "#{Vote.count} votes created"
