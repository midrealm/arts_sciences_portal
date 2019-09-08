Rails.application.routes.draw do
  devise_for :users

  root :to => ApplicationController

  scope "/admin" do
    get '/', to: 'admin#index', as: 'admin'
    resources :users, except: :new
    resources :user_roles
  end
end
