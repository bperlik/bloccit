Rails.application.routes.draw do
  # resources :topics
  # resources :posts
  # changed resources to show passing resources :posts block to resources :topics block for nesting
    resources :topics do
      resources :posts, except: [:index]
    end

   # use only: [ ] so no /posts/:id routes are created,
   #  just posts/:post_id/comments routes
   #  add create and destroy routes for comments
   #  comments will display on posts show view, so index, new arent needed
   #  also users won't view or edit indiv comments, so show, update & edit aren't needed

   resources :posts, only: [] do
     resources :comments, only: [:create, :destroy]
   end

   #create new and create actions, only hash key prevents unnec. route code
    resources :users, only:[:new, :create]

    resources :sessions, only: [:new, :create, :destroy]
#  get 'welcome/index'

#  get 'welcome/about'

# remove the get "welcome/index" because the root is declared as index
# modify the about route to allow users to visit/about rather than /welcome/about

  get 'about' => 'welcome#about'

  root 'welcome#index'

end
