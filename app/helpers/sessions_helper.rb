module SessionsHelper
  # session have one to one relationship with user ids
   def create_session(user)
     session[:user_id] = user.id
   end

 # clear the user id on the session by setting user_id to nil
 # essentially destroys session because cannot be tracked by id
   def destroy_session(user)
     session[:user_id] = nil
   end

   # current user acts as shortcut to find current session by user id
   def current_user
     User.find_by(id: session[:user_id])
   end
 end
