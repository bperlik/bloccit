Rails.application.routes.draw do
#  get 'posts/index'

#  get 'posts/show'

#   get 'posts/new'

#   get 'posts/edit'

# call the resources method and pass it a Symbol
# Rails will create routes for creating, updating, viewing and 
# deleting instances of the Post
  resources :posts

#  get 'welcome/index'

#  get 'welcome/about'

# remove the get "welcome/index" because the root is declared as index
# modify the about route to allow users to visit/about rather than /welcome/about

  get 'about' => 'welcome#about'

  root 'welcome#index'

end
