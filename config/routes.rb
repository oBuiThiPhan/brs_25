Rails.application.routes.draw do
  get "books/index"

  root "static_pages#home"
  get "help" => "static_pages#help"
  get "contact" => "static_pages#contact"

  get "signup" => "users#new"
  get "login" => "sessions#new"
  post "login" => "sessions#create"
  delete "logout" => "sessions#destroy"

  resources :users
  resources :books, only: [:index]

  namespace :admin do
    root "sessions#new"
    resources :books
    resources :users, only: [:index, :destroy]
  end
end
