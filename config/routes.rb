Textweb::Application.routes.draw do

  match 'terms-of-service' => 'public#terms_of_service', :as => :terms
  match 'privacy' => 'public#privacy', :as => :privacy

  resources :password_resets

  root :to => 'public#index'

  get "signup" => "users#new", :as => "signup"
  get "logout" => "sessions#destroy", :as => "logout"
  get "login" => "sessions#new", :as => "login"
  get "courses/:id/topic/:topic_id" => "courses#show", :as => "course_topic"

  get '/links/:id', to: 'links#show', :as => 'link'

  match '/rate' => 'links#rate', :as => 'rate'
  
  resources :sessions, :only => [:new, :create, :destroy]
  resources :courses, :only => [:show]
  resources :links, :only => [:create, :show]

  resources :users do
    member do
      get :email_verification
      get :email_confirmation_page
      post :resend_activation_email
      get :profile
      post :change_password
    end
  end

  resources :schools do
    collection do
      get :set_session
      get :home
      get :courses
    end
  end
  
  root :to => 'public#index'

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
end
