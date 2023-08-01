Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "prototypes#index"
  get 'prototypes/new', to: 'prototypes#new'
  resources :prototypes do
    resources :comments, only: :create
  end
  resources :prototypes, only: [:index, :new, :create, :show, :destroy, :edit, :update]
  resources :users, only: :show
end
