class PostsController < ApplicationController
  def index
    #declare an instance var @posts & assign it a collection of Post objects
    # using the all method, provided by ActiveRecord
    @posts = Post.all
    @posts.each do |post|
      post.update!(title: "SPAM") if (post.id % 5 == 1)
    end
  end

  def show
  end

  def new
  end

  def edit
  end
end
