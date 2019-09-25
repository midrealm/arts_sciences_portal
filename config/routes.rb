Rails.application.routes.draw do
  devise_for :users

  root 'pages#home'

  resources :entries
  resources :judge_assigns

  scope "/admin" do
    resources :users, except: :new
    resources :user_roles
    resources :categories
    resources :divisions
    resources :regions
    resources :fairs
    resources :judge_assigns
  end
end
