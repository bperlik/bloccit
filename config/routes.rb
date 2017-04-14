Rails.application.routes.draw do
  #updated to use resourceful routing
  resources :advertisements
  resources :posts

  get 'about'=> 'welcome#about'

  root to: 'welcome#index'

end
