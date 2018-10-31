Rails.application.routes.draw do
  devise_for :users
  get 'users/profile'

  get 'users/:id/edit', to: 'users#edit', as: :edit_user
  put 'users/:id', to: 'users#update', as: :update_user

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'users#profile'
  # get 'users/profile', as: 'user_root'
  get 'users/lessons', to: 'users#lessons'
  get 'users/control_undef_users', to: 'users#control_undef_users'
  get 'users/control_all', to: 'users#control_all'
  get 'users/control_students', to: 'users#control_students'
  get 'users/:id/edit_student', to: 'users#edit_student', as: 'users_edit_student'
  put 'users/:id/update_student_form', to: 'users#update_student_form', as: 'update_student_form'
  delete 'users/:id/destroy_user', to: 'users#destroy_user', as: 'destroy_user'
  get 'users/notes', to: 'notes#index'
  resources :notes
end
