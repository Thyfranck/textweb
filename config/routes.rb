Courselinks::Application.routes.draw do

  namespace :admin do
    resources :schools do
      resources :courses do
        resources :moderators
        resources :topics do
          resources :sections do
            resources :links
          end
        end
      end
    end
  end

  match 'suggest-course-submit' => 'public#suggest_course_submit', :as => :suggest_course_submit
  match 'suggest-course' => 'public#suggest_course', :as => :suggest_course
  match 'terms-of-service' => 'public#terms_of_service', :as => :terms
  match 'privacy' => 'public#privacy', :as => :privacy

  resources :password_resets
  resources :replies, :only => [:create, :destroy]

  get "signup" => "users#new", :as => "signup"
  get "logout" => "sessions#destroy", :as => "logout"
  get "login" => "sessions#new", :as => "login"

  get '/courses/:course_id', to: 'courses#show', :as => 'course'
  get '/courses/:course_id/topics/:topic_id', to: 'courses#show', :as => 'course_topic'
  get '/courses/:course_id/topics/:topic_id/sections/:section_id', to: 'courses#show', :as => 'course_topic_section'
  get '/courses/:course_id/topics/:topic_id/sections/:section_id/links/:link_id', to: 'links#show', :as => 'course_topic_section_link'

  
  resources :sessions, :only => [:new, :create, :destroy]

  resources :comments, :only => [:create, :destroy]
  
  resources :links, :only => [:create, :destroy] do
    member do
      get :vote
      get :approve
      get :download
    end
  end

  resources :users do
    member do
      get :email_verification
      get :email_confirmation_page
      post :resend_activation_email
      post :change_password
      get :settings
    end
  end

  resources :schools do
    collection do
      get :set_session
      get :home
      get :courses
    end
  end

  root :to => 'schools#home'
  #root :to => 'public#index'

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
end
