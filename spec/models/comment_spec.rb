require 'rails_helper'

RSpec.describe Comment, type: :model do
  let(:topic) { create(:topic) }
  let(:user) { create(:user) }
  let(:post) { create(:post) }

  # create a comment and associate a user
  let(:comment) { Comment.create!(body: 'Comment Body', post: post, user: user) }

  # test that comment belongs to a use and to a post
  it { is_expected.to belong_to(:post) }
  it { is_expected.to belong_to(:user) }

  #  test that comment's body is present and min length 5
  it { is_expected.to validate_presence_of(:body) }
  it { is_expected.to validate_length_of(:body).is_at_least(5) }

  describe "attributes" do
    it "has a body attribute" do
      expect(comment).to have_attributes(body: "Comment Body")
    end
  end
   describe "after_create" do
 # initialize but don't save a new comment for post
     before do
       @another_comment = Comment.new(body: 'Comment Body', post: post, user: user)
     end

 # favorite a post then expect mailer will receie a call
     # to new_comment, then save another comment to trigger the after create callback
     it "sends an email to users who have favorited the post" do
       favorite = user.favorites.create(post: post)
       expect(FavoriteMailer).to receive(:new_comment).with(user, post, @another_comment).and_return(double(deliver_now: true))

       @another_comment.save!
     end

     # test that fav-mailer does not receive a call to new_comment when post is NOT faved
     it "does not send emails to users who haven't favorited the post" do
       expect(FavoriteMailer).not_to receive(:new_comment)

       @another_comment.save!
     end
   end

end

