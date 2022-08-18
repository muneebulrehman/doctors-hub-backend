Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  namespace :api do
    post '/users', to: 'users#create'
    post '/login', to: 'users#login'
    resources :doctors, only: [:index, :show]
    resources :appointments, only: [:index, :show, :create]
  end

  # Defines the root path route ("/")
  root to: "home#index"
end
