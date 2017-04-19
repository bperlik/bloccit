require 'random_data'

#create posts
50.times do

  #use create with a band (!) to raise an error if there's a problem
  Post.create!(

    # use methods from a class that doesn't exist yet, RandomData
    # that will create random strings for title and body
    # wishful coding = writing code for classes and methods that don't
    # exist because it keeps you focused and saves time
    title:  RandomData.random_sentence,
    body:   RandomData.random_paragraph
    )
end

posts=Post.all

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

#create questions in same manner as posts but add resolved: false
50.times do
  Question.create!(
    title: RandomData.random_sentence,
    body: RandomData.random_paragraph,
    resolved: false)
end

puts "Seed finished"
puts "#{Post.count} posts created"
puts "#{Comment.count} comments created"
puts "#{Question.count} questions created"
