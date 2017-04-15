require 'rails_helper'

RSpec.describe PostsController, type: :controller do
# create a post and assign it to my_post using let
# use RandomData to give my_post a random title and body
  let(:my_post) { Post.create!(title: RandomData.random_sentence, body: RandomData.random_paragraph) }

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end

    it "assigns [my_post] to @posts" do
      get :index
# my test created one post, we expect index to return array of one item
# use assigns (method of ActionController:TestCase) to give test access to
# instance variables assigned in the action that are availble for the view
      expect(assigns(:posts)).to eq([my_post])
    end
  end

  describe "GET show" do
    it "returns http success" do
      # pass {id: my_post_id} to show as parameter, parms are passed to the params hash
      get :show, {id: my_post.id}
      expect(response).to have_http_status(:success)
    end

    it "renders the #show view" do
      # expect the respose to return the show view using render_template
      get :show, {id: my_post.id}
      expect(response).to render_template :show
    end

    it "assigns my_post to @post" do
      get :show, {id: my_post.id}
      #post should equal my_post because we call show with id of my_post
      expect(assigns(:post)).to eq(my_post)
    end
  end

  #  new - new and unsaved Post is created (create would be saved in database)
  describe "GET #new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end

    # expect the #new controller to render the post new view, use render_template to verify
    it "renders the #new view" do
      get :new
      expect(response).to render_template :new
    end

    # expect the @post instance variable to be initialize by controller#new
    # assigns gives access tothe @post var, assign it to :post
    it "instantiates @post" do
      get :new
      expect(assigns(:post)).not_to be_nil
    end
  end

    # expect that after controller#create is called with parameters
    # that the count of Post instances (rows in posts table) will increase by one

  describe "POST create" do
    it "increases the number of Post by 1" do
      expect{post :create, post: {title: RandomData.random_sentence, body: RandomData.random_paragraph}}.to change(Post, :count).by(1)
    end

    #expect newly created post to be assigned to @post
    it "assigns the new post to @post" do
      post :create, post: {title: RandomData.random_sentence, body: RandomData.random_paragraph}
      expect(assigns(:post)).to eq Post.last
    end

    #expect to be directed to the newly create post
    it "redirects to the new post" do
      post :create, post: {title: RandomData.random_sentence, body: RandomData.random_paragraph}
      expect(response).to redirect_to Post.last
    end
  end

  describe "GET edit" do
    it "returns http success" do
      get :edit, {id: my_post.id}
      expect(response).to have_http_status(:success)
    end

   # expect the edit view to render
    it "renders the #edit view" do
      get :edit, {id: my_post.id}
      expect(response).to render_template :edit
    end

   # edit should assign the post to be updated to @post
    it "assigns post to be updated to @post" do
      get :edit, {id: my_post.id}

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

      put :update, id: my_post.id, post: {title: new_title, body: new_body}

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
     put :update, id: my_post.id, post: {title: new_title, body: new_body}
     expect(response).to redirect_to my_post
    end
  end

  describe "DELETE destroy" do
    it "deletes the post" do
      delete :destroy, {id: my_post.id}
      # search the db for post with id equal to my_post.id
      # returns an array, assign size of array to count
      # expect count to equal zero, which means that post was deleted
      count = Post.where({id: my_post.id}).size
      expect(count).to eq 0
    end

    it "redirects to posts index" do
      delete :destroy, {id: my_post.id}
    # expect to be redirected to posts index view after post was deleted
      expect(response).to redirect_to posts_path
    end
  end
end

