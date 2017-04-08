require 'rails_helper'

RSpec.describe Post, type: :model do

  # use let method to create new instance of Post class, name it post
  # let dynamically defines the (post) method, when first called within a spec
  # (the it bloc) computes and stores the return value
  let (:post) { Post.create!(title: "New Post Title", body: "New Post Body") }

  # test whether post has attributes named title and body
  # post should return a non-nil value when post.title and post.body are called
  describe "attributes" do
    it "has title and body attributes" do
      expect(post).to have_attributes(title: "New Post Title", body: "New Post Body")
    end
  end
end
