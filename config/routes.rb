Rails.application.routes.draw do
  devise_for :users
  get 'users/profile'

  get 'users/:id/edit', to: 'users#edit', as: :edit_user
  put 'users/:id', to: 'users#update', as: :update_user
  get 'users/:id/show', to: 'users#show', as: :user_show
  root 'users#profile'
  # get 'users/profile', as: 'user_root'
  get 'lessons/index', to: 'lessons#index'
  get 'users/control_undef_users', to: 'users#control_undef_users'
  get 'users/control_all', to: 'users#control_all'
  put 'users/:id/update_student_form', to: 'users#update_student_form', as: 'update_student_form'
  delete 'users/:id/destroy_user', to: 'users#destroy_user', as: 'destroy_user'
  get 'users/notes', to: 'notes#index'
  get 'lessons/list_form_lessons', to: 'lessons#list_form_lessons'
  get 'lessons/:id/edit', to: 'lessons#edit', as: 'lessons_edit_lesson'
  put 'lessons/:id/update', to: 'users#update', as: 'lessons_update_lesson'
  delete 'lessons/:id/destroy', to: 'lessons#destroy', as: 'lessons_destroy_lesson'

  get 'grades/list_form', to: 'grades#list_form'
  get 'grades/list_subject', to: 'grades#list_subject'
  get 'grades/index_for_student', to: 'grades#index_for_student'
  get 'users_and_subject/set_teacher_subject', to: 'users_and_subject#set_teacher_subject'
  post 'users_and_subject/new', to: 'users_and_subject#create', as: :new_users_and_subject

  resources :notes
  resources :lessons
  resources :forms
  resources :grades
  resources :users_and_subject
  resources :homeworks, only: [:show, :new, :create, :update, :edit]
end
