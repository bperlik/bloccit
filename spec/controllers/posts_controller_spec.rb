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

  describe "Get show" do
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
end
