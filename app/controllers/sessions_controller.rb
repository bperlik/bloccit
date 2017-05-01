class SessionsController < ApplicationController
  def new
  end

  def create
  # search the database for user with email address in params hash
  # use downcase to normalize the email address
    user = User.find_by(email: params[:session][:email].downcase)

  # verify user is not nill and password in params hash matches
  # exit early if user is nil
  # if user is successful authenticated, create_session  and
  # redirect user to root_path
  # if notsuccessful, flash a warning message and render new view
    if user && user.authenticate(params[:session][:password])
      create_session(user)
      flash[:notice] = "Welcome, #{user.name}!"
      redirect_to root_path
    else
      flash.now[:alert] = 'Invalid email/password combination'
      render :new
    end
  end

  # destroy method will delete a user's session, logs the user out by
  # calling destroy_session(current_user), flash notice about log out
  # redirect o root_path
  def destroy
    destroy_session(current_user)
    flash[:notice] = "You've been signed out, come back soon!"
    redirect_to root_path
  end
end
