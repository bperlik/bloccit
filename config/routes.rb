Rails.application.routes.draw do
  # resources :topics
  # resources :posts
  # changed resources to show passing resources :posts block to resources :topics block for nesting
    resources :topics do
      resources :posts, except: [:index]
    end

   #create new and create actions, only hash key prevents unnec. route code
    resources :users, only:[:new, :create]
#  get 'welcome/index'

#  get 'welcome/about'

# remove the get "welcome/index" because the root is declared as index
# modify the about route to allow users to visit/about rather than /welcome/about

  get 'about' => 'welcome#about'

  root 'welcome#index'

end
