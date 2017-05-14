include RandomData

FactoryGirl.define do
  factory :comment do
    body 'Comment Body'
    user
    post
  end
end

