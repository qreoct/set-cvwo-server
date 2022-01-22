Rails.application.routes.draw do

  post '/login',    to: 'sessions#create'
  post '/logout',   to: 'sessions#destroy'
  get '/logged_in', to: 'sessions#is_logged_in?'

  post '/users',         to: 'users#create'
  get '/users/:user_id', to: 'users#show'
  get '/users',          to: 'users#index'

  resources :tags

  resources :todos do
    get :tags, on: :member
  end

  resources :users
    get 'todos/index'
    get 'todos/create'
    get 'todos/update'
    get 'todos/destroy'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
