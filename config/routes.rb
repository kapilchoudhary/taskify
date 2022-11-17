# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users

  resources :projects do
    resources :tasks
    resources :comments, module: :projects
    get "search", on: :collection
  end

  resources :tasks do
    resources :comments, module: :tasks
  end

  get '/your_tasks', to: 'home#user_tasks'
  get '/search_tasks', to: 'home#search_tasks'
  root 'home#index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
