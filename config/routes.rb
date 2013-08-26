Textweb::Application.routes.draw do

  match 'terms-of-service' => 'public#terms_of_service', :as => :terms
  match 'privacy' => 'public#privacy', :as => :privacy

  resources :password_resets

  root :to => 'public#index'

  get "signup" => "users#new", :as => "signup"
  get "logout" => "sessions#destroy", :as => "logout"
  get "login" => "sessions#new", :as => "login"

#  get '/links/:id', to: 'links#show', :as => 'link'

  match '/vote' => 'links#vote', :as => 'vote'

  get '/courses/:course_id', to: 'courses#show', :as => 'course'
  get '/courses/:course_id/topics/:topic_id', to: 'courses#show', :as => 'course_topic'
  get '/courses/:course_id/topics/:topic_id/sections/:section_id', to: 'courses#show', :as => 'course_topic_section'
  get '/courses/:course_id/topics/:topic_id/sections/:section_id/links/:link_id', to: 'links#show', :as => 'course_topic_section_link'


  
  resources :sessions, :only => [:new, :create, :destroy]
  
  resources :links, :only => [:create]

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

  match 'school-home' => 'schools#home', :as => :school_home
  
  root :to => 'public#index'

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
end
