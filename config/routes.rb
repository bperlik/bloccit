Rails.application.routes.draw do
#remove all routing except the following and add resources :questions
  resources :posts
  resources :questions

# remove the get "welcome/index" because the root is declared as index
# modify the about route to allow users to visit/about rather than /welcome/about

  get 'about' => 'welcome#about'

  root 'welcome#index'

end
