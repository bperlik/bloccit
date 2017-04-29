Rails.application.routes.draw do
 # changed resources to show passing resources :posts block to resources :topics block for nesting
    resources :topics do
      resources :posts, except: [:index]
      resources :sponsored_posts, except: [:index]
    end
# remove the get "welcome/index" because the root is declared as index
# modify the about route to allow users to visit/about rather than /welcome/about

  get 'about' => 'welcome#about'

  root 'welcome#index'

end
