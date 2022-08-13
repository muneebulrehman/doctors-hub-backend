Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  namespace :api do
    post '/users', to: 'users#create'
    post '/login', to: 'users#login'
  end

  # Defines the root path route ("/")
  # root "articles#index"
end
