 # define a factory for topics
# the generates a topic with random name & description
 FactoryGirl.define do
   factory :topic do
     name RandomData.random_name
     description RandomData.random_sentence
   end
 end
