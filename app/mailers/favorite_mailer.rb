class FavoriteMailer < ApplicationMailer
  default from: "barbperlik@gmail.com"

  def new_comment(user, post, comment)

  # three different headers to enable conversational threading
     headers["Message-ID"] = "<comments/#{comment.id}@bloccit.example>"
     headers["In-Reply-To"] = "<post/#{post.id}@bloccit.example>"
     headers["References"] = "<post/#{post.id}@bloccit.example>"

     @user = user
     @post = post
     @comment = comment

  # use the mail method (take hash of to address, subject, an from (default) and cc/bcc)
     mail(to: user.email, subject: "New comment on #{post.title}", cc: "rizwanreza@bloc.io")
   end

  def new_post(post)
    headers["Message-ID"] = "<posts/#{post.id}@bloccit.example>"
    headers["In-Reply-To"] = "<posts/#{post.id}@bloccit.example>"
    headers["References"] = "<posts/#{post.id}@bloccit.example>"

    @post = post

    mail(to: post.user.email, subject: "Your post, #{post.title}, has been favorited!")
  end
end

