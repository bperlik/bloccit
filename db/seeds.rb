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
  Post.create!(

    # use methods from a class that doesn't exist yet, RandomData
    # that will create random strings for title and body
    # wishful coding = writing code for classes and methods that don't
    # exist because it keeps you focused and saves time
    user:   users.sample,
    topic:  topics.sample,
    title:  RandomData.random_sentence,
    body:   RandomData.random_paragraph
    )
end
posts = Post.all

#create comments
100.times do
  Comment.create!(
    # call sample on the array returned by Post.all in order to pick a random
    # post to associate each comment with
    # Sample - returns a random element from the array when its called
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
