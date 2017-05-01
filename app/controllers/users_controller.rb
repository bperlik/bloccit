class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
  # create a user with new and set attributes from params hash
     @user = User.new
     @user.name = params[:user][:name]
     @user.email = params[:user][:email]
     @user.password = params[:user][:password]
     @user.password_confirmation = params[:user][:password_confirmation]

     # save the new user,
     # if successful, message user and redirect to root path
     # if not, display error and render new view to try again
     if @user.save
       flash[:notice] = "Welcome to Bloccit #{@user.name}!"
       redirect_to root_path
     else
       flash.now[:alert] = "There was an error creating your account. Please try again."
       render :new
     end
  end
end
