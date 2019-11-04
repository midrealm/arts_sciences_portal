Rails.application.routes.draw do
  devise_for :users

  root 'pages#home'

  resources :entries

  scope "/admin" do
    resources :users, except: :new do
      resources :judge_preferences, only: [:new, :create, :index, :destroy]
    end
    resources :user_roles
    resources :categories do
      get 'scoresheet', on: :member
    end
    resources :divisions
    resources :regions
    resources :fairs do
      get 'view_schedule', on: :member, to: 'fairs#view_schedule'
      post 'schedule', on: :member, to: 'fairs#submit_schedule'
      get 'schedule', on: :member
    end
    resources :timeslots
    resources :criteria
    resources :criteria_types
    resources :criteria_descriptions
    resources :judge_assigns
  end
end
