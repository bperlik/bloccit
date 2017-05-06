require 'rails_helper'
# add SessionsHelper to use the create_session(user) method later
include SessionsHelper

RSpec.describe PostsController, type: :controller do
  # create a post and assign it to my_post using let
  # use RandomData to give my_post a random title and body
  # create a parent topic, then create a topic.posts so it will belong to my_topic
  let(:my_user) { User.create!(name: "Bloccit User", email: "user@bloccit.com", password: "hellowword") }
  let(:my_topic) { Topic.create!(name: RandomData.random_sentence, description: RandomData.random_paragraph) }
  let(:my_post) { my_topic.posts.create!(title: RandomData.random_sentence, body: RandomData.random_paragraph, user: my_user) }
   # index tests are removed because posts no longer uses an index view, they are on show view of parent topic

   # add a context for a guest (un-signed-in) user. Contexts organize tests based on the state of an object.
   context "guest user" do
     # we define the show tests, which allow guest to view posts in Bloccit
     describe "GET show" do
       it "returns http success" do
         get :show, topic_id: my_topic.id, id: my_post.id
         expect(response).to have_http_status(:success)
       end

       it "renders the #show view" do
         get :show, topic_id: my_topic.id, id: my_post.id
         expect(response).to render_template :show
       end

       it "assigns my_post to @post" do
         get :show, topic_id: my_topic.id, id: my_post.id
         expect(assigns(:post)).to eq(my_post)
       end
     end

     # we define tests for the other CRUD actions. don’t allow quests to access the actions
     describe "GET new" do
       it "returns http redirect" do
         get :new, topic_id: my_topic.id
         # expect guests to the redirected if they attempt to act on a post
         expect(response).to redirect_to(new_session_path)
       end
     end

     describe "POST create" do
       it "returns http redirect" do
         post :create, topic_id: my_topic.id, post: {title: RandomData.random_sentence, body: RandomData.random_paragraph}
         expect(response).to redirect_to(new_session_path)
       end
     end

     describe "GET edit" do
       it "returns http redirect" do
         get :edit, topic_id: my_topic.id, id: my_post.id
         expect(response).to redirect_to(new_session_path)
       end
     end

     describe "PUT update" do
       it "returns http redirect" do
         new_title = RandomData.random_sentence
         new_body = RandomData.random_paragraph

         put :update, topic_id: my_topic.id, id: my_post.id, post: {title: new_title, body: new_body}
         expect(response).to redirect_to(new_session_path)
       end
     end

     describe "DELETE destroy" do
       it "returns http redirect" do
         delete :destroy, topic_id: my_topic.id, id: my_post.id
         expect(response).to have_http_status(:redirect)
       end
     end
   end


     # wrap the existing specs in a context so they become our signed-in user specs
     context "signed-in user" do
       before do
           create_session(my_user)
       end

       describe "GET show" do
         it "returns http success" do
           get :show, topic_id: my_topic.id, id: my_post.id
           expect(response).to have_http_status(:success)
         end

         it "renders the #show view" do
           get :show, topic_id: my_topic.id, id: my_post.id
           expect(response).to render_template :show
         end

         it "assigns my_post to @post" do
           get :show, topic_id: my_topic.id, id: my_post.id
           expect(assigns(:post)).to eq(my_post)
         end
       end

       # expect that after controller#create is called with parameters
       # that the count of Post instances (rows in posts table) will increase by one
      describe "POST create" do
        it "increases the number of Post by 1" do
          expect{post :create, topic_id: my_topic.id, post: {title: RandomData.random_sentence, body: RandomData.random_paragraph}}.to change(Post, :count).by(1)
        end

        #expect newly created post to be assigned to @post
        it "assigns the new post to @post" do
          post :create, topic_id: my_topic.id, post: {title: RandomData.random_sentence, body: RandomData.random_paragraph}
          expect(assigns(:post)).to eq Post.last
        end

        #expect to be directed to the newly create post
        it "redirects to the new post" do
          post :create, topic_id: my_topic.id, post: {title: RandomData.random_sentence, body: RandomData.random_paragraph}
          expect(response).to redirect_to [my_topic, Post.last]
        end
      end

      describe "GET edit" do
        it "returns http success" do
          get :edit, topic_id: my_topic.id, id: my_post.id
          expect(response).to have_http_status(:success)
        end

          # expect the edit view to render
          it "renders the #edit view" do
          get :edit, topic_id: my_topic.id, id: my_post.id
          expect(response).to render_template :edit
        end

        # edit should assign the post to be updated to @post
        it "assigns post to be updated to @post" do
          get :edit, topic_id: my_topic.id, id: my_post.id

          post_instance = assigns(:post)

          expect(post_instance.id).to eq my_post.id
          expect(post_instance.title).to eq my_post.title
          expect(post_instance.body).to eq my_post.body
        end
      end

      describe "PUT update" do
        it "updates the post with expected attributes" do
          new_title = RandomData.random_sentence
          new_body = RandomData.random_paragraph

          put :update, topic_id: my_topic.id, id: my_post.id, post: {title: new_title, body: new_body}

          # test that @post was updated with title and body passed in
          # and that @post's id was not changed
          updated_post = assigns(:post)
          expect(updated_post.id).to eq my_post.id
          expect(updated_post.title).to eq new_title
          expect(updated_post.body).to eq new_body
        end

       it "redirects to the updated post" do
         new_title = RandomData.random_sentence
         new_body = RandomData.random_paragraph

         # test to be redirected to the post's show view after update
         put :update, topic_id: my_topic.id, id: my_post.id, post: {title: new_title, body: new_body}
         expect(response).to redirect_to [my_topic, my_post]
        end
      end

      describe "DELETE destroy" do
        it "deletes the post" do
          delete :destroy, topic_id: my_topic.id, id: my_post.id
          # search the db for post with id equal to my_post.id
          # returns an array, assign size of array to count
          # expect count to equal zero, which means that post was deleted
          count = Post.where({id: my_post.id}).size
          expect(count).to eq 0
        end

        it "redirects to topic show" do  # redirects to topic show because of nesting
          delete :destroy, topic_id: my_topic.id, id: my_post.id
          # expect to be redirected to posts index view after post was deleted
          expect(response).to redirect_to my_topic
      end
    end
  end
end
