Rails.application.routes.draw do

  root "static_pages#home"
  get "help" => "static_pages#help"
  get "contact" => "static_pages#contact"

  get "signup" => "users#new"
  get "login" => "sessions#new"
  post "login" => "sessions#create"
  delete "logout" => "sessions#destroy"

  resources :books, only: [:index, :show]

  resources :requests, except: [:show, :edit, :update]

  resources :users
  resources :users do
    get "/:relationship", on: :member,
      :to => "relationships#index", :as => :relationships
  end

  resources :relationships, only: [:create, :destroy]

  namespace :admin do
    root "sessions#new"
    resources :categories
    resources :books
    resources :requests, only: [:index, :destroy]
    resources :users, only: [:index, :destroy]
  end
end
