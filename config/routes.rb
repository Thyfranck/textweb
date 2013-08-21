Textweb::Application.routes.draw do
  
  resources :password_resets

  root :to => 'public#index'

  get "signup" => "users#new", :as => "signup"
  get "logout" => "sessions#destroy", :as => "logout"
  get "login" => "sessions#new", :as => "login"

  match '/rate' => 'links#rate', :as => 'rate'
  
  resources :sessions
  resources :courses
  resources :links

  resources :users do
    member do
      get :email_verification
      get :email_confirmation_page
      post :resend_activation_email
      get :profile
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
