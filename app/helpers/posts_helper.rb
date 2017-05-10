module PostsHelper
   # Returns: permission = true/false for actions = [new, edit, delete]
  def user_is_authorized_for_post?(post, action)
    if  current_user && (current_user == post.user || current_user.admin?)
      # An Admin or the author of a post can do any action.
      return true
    elsif current_user && current_user.moderator? && (action == 'edit')
      # A Moderator can edit any post
      return true
    else
      # All other actions are not allowed to Members and Moderators
      return false
    end
  end
end

