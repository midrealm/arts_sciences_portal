Rails.application.routes.draw do
  devise_for :users

  root 'pages#home'

  resources :entries do
    get 'schedule', on: :collection
    post 'schedule', on: :collection, to: 'entries#submit_schedule'
  end

  scope "/admin" do
    resources :users, except: :new do
      resources :judge_preferences, only: [:new, :create, :index, :destroy]
    end
    resources :user_roles
    resources :categories
    resources :divisions
    resources :regions
    resources :fairs do
      get 'schedule', on: :collection
    end
    resources :timeslots
    resources :judge_assigns
  end
end
