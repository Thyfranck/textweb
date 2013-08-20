Textweb::Application.routes.draw do
  
  root :to => 'public#index'

  get "signup" => "users#new", :as => "signup"
  get "logout" => "sessions#destroy", :as => "logout"
  get "login" => "sessions#new", :as => "login"
  
  resources :sessions
  resources :courses
  resources :links

  resources :users do
    member do
      get :email_verification
      get :email_confirmation_page
      post :resend_activation_email
    end
  end

  resources :schools do
    collection do
      get :set_session
      get :home
      get :courses
    end
  end


  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
end
