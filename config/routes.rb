Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  namespace :api do
    post '/users', to: 'users#create'
    post '/login', to: 'users#login'
  end

  # Defines the root path route ("/")
  # root "articles#index"
end
