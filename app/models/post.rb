class Post < ActiveRecord::Base
  belongs_to :topic
  belongs_to :user
  has_many :comments, dependent: :destroy

  # add the votes association to Post
  # this relates the models & allows a call of post.votes
  # add dependent: :destroy so votes are destroyed when a parent post is deleted
  has_many :votes, dependent: :destroy
  has_many :favorites, dependent: :destroy

  default_scope { order('rank DESC') }

  # 15 use lambd -> to ensure that user is present and signed in
  # if user present, return all posts
  # if not, use ActiveRecord joins method to retrieve
  # all posts that belong to public post
  scope :visible_to, -> (user) { user ? all : joins(:topic).where('topics.public' => true) }

  validates :title, length:{ minimum: 5 }, presence: true
  validates :body, length: { minimum: 20 }, presence: true
  validates :topic, presence: true
  validates :user, presence: true

   def up_votes
   # find up votes by a post by pass value: 1 to where
   # fetches a collection of votes with value of 1
   # then call count on collection to get a total of all up votes
     votes.where(value: 1).count
   end

   def down_votes
   # find down votes by similarly passing value of -1
     votes.where(value: -1).count
   end

   def points
   # use ActiveRecord's sum method to add value of all given post's votes
   # passing :value indicates which attribute to sum in the collection
     votes.sum(:value)
   end

   def update_rank
     age_in_days = (created_at - Time.new(1970,1,1)) / 1.day.seconds
     new_rank = points + age_in_days
     update_attribute(:rank, new_rank)
   end
end
