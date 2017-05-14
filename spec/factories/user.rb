FactoryGirl.define do
   pw = RandomData.random_sentence
 # declare the name of the factory
   factory :user do
     name RandomData.random_name
 # each user has a unique email address using sequence
     # sequence generates unique values in a specified format
     sequence(:email){|n| "user#{n}@factory.com" }
     password pw
     password_confirmation pw
     role :member
   end
 end
