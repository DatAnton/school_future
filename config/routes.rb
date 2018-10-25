Rails.application.routes.draw do
  devise_for :users
  get 'users/profile'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'users#profile'
  # get 'users/profile', as: 'user_root'
  get 'users/lessons', to: 'users#lessons'
  get 'users/control_users', to: 'users#control_users'
  get 'users/notes', to: 'notes#index'
  resources :notes
end
