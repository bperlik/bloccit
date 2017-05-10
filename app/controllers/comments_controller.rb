class CommentsController < ApplicationController

   # require sign in to ensure guests users can't create coments
   before_action :require_sign_in
   # define authorize_user method to allow comment owner or admin user
   # to deltet the comment, redirect others to post show view
   before_action :authorize_user, only: [:destroy]

    def destroy
     @post = Post.find(params[:post_id])
     comment = @post.comments.find(params[:id])

     if comment.destroy
       flash[:notice] = "Comment was deleted."
       redirect_to [@post.topic, @post]
     else
       flash[:alert] = "Comment couldn't be deleted. Try again."
       redirect_to [@post.topic, @post]
     end
   end

   def create
     # find correct post using post_id
     # then create a new comment using comment_params
     @post = Post.find(params[:post_id])
     comment = @post.comments.new(comment_params)
     comment.user = current_user

     if comment.save
       flash[:notice] = "Comment saved successfully."
        # rediret to posts show view
       redirect_to [@post.topic, @post]
     else
       flash[:alert] = "Comment failed to save."
        #redirect to post show view
       redirect_to [@post.topic, @post]
     end
   end

   private

   # define a private comment_params method to
   # white list the paramaters we need to create comments
   def comment_params
     params.require(:comment).permit(:body)
   end

   def authorize_user
     comment = Comment.find(params[:id])
     unless current_user == comment.user || current_user.admin?
       flash[:alert] = "You do not have permission to delete a comment."
       redirect_to [comment.post.topic, comment.post]
     end
   end
 end
