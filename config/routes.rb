Rails.application.routes.draw do
  devise_for :users

  root 'pages#home'

  resources :entries

  scope "/admin" do
    resources :users, except: :new do
      resources :judge_preferences, only: [:new, :create, :index, :destroy]
    end
    resources :user_roles
    resources :categories
    resources :divisions
    resources :regions
    resources :fairs
    resources :timeslots

    resources :judge_assigns do
      get 'schedule', on: :collection
    end
  end
end
