InspireMe::Application.routes.draw do

  root :to => 'welcome#index'

  get 'signup' => 'users#new', :as => 'signup'
  get 'login' => 'sessions#new', :as => 'login'
  get 'logout' => 'sessions#destroy', :as => 'logout'

  resources :passwordresets
  resources :users
  resources :sessions
  resources :home
  resources :ideas
  resources :lists
  resources :password_resets
  resources :friendships
  resources :listings


end
