Rails.application.routes.draw do
  devise_for :users
  resources :projects do
    resources :tasks
  end
  get '/all_tasks', to: 'home#show_all_task'
  root 'home#index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
