Rails.application.routes.draw do
  resources :categories
  devise_for :users, :controllers => { :registrations => "registrations" }

  unauthenticated :user do
    root to: "pages#home", as: :unauthorized_root_path
  end

  authenticated :user do
    root to: 'dashboard#index'
  end

  get 'review', to: 'dashboard#review', as: 'review'

  resources :entries do
    get 'promote', on: :member, to: 'entries#promote'
    get 'cover_sheet', on: :member, to: 'entries#cover_sheet'
    resources :user_entries, only: [:new, :create, :index, :destroy]
    resources :scoresheets, only: [:new, :create, :show, :update, :edit, :destroy]
  end

  scope "/admin" do
    resources :users, except: :new do
      resources :judge_preferences, only: [:new, :create, :index]
    end
    resources :user_roles
    resources :divisions do
      get 'scoresheet', on: :member
    end
    resources :regions
    resources :fairs do
      get 'view_schedule', on: :member, to: 'fairs#view_schedule'
      post 'schedule', on: :member, to: 'fairs#submit_schedule'
      get 'schedule', on: :member
      get 'review', on: :member
      get 'tallyroom', on: :member, to: 'fairs#tallyroom'
      resources :judge_assigns
    end
    resources :timeslots
    resources :criteria
    resources :criteria_types
    resources :criteria_descriptions
    resources :applicable_criteria
    resources :scoresheets, only: [:index]
    resources :scores
    resources :judge_fairs, except: [:show]
    resources :locations
    resources :peerages
  end
end
