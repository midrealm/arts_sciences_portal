Rails.application.routes.draw do
  resources :divisions
  resources :categories
  resources :judge_assigns
  resources :entries
  devise_for :users

  root 'pages#home'

  resources :entries
  resources :judge_assigns

  scope "/admin" do
    resources :users, except: :new
    resources :user_roles
    resources :categories
    resources :divisions
  end
end
