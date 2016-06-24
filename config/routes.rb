Rails.application.routes.draw do

  root "static_pages#home"
  get "help" => "static_pages#help"
  get "contact" => "static_pages#contact"

  get "signup" => "users#new"
  get "login" => "sessions#new"
  post "login" => "sessions#create"
  delete "logout" => "sessions#destroy"

  resources :users
  resources :books, only: [:index, :show]
  resources :requests, except: [:show, :edit, :update]

  namespace :admin do
    root "sessions#new"
    resources :categories
    resources :books
    resources :users, only: [:index, :destroy]
  end
end
