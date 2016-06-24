Rails.application.routes.draw do
  root "static_pages#home"
  get "help" => "static_pages#help"
  get "contact" => "static_pages#contact"

  get "signup" => "users#new"
  get "login" => "sessions#new"
  post "login" => "sessions#create"
  delete "logout" => "sessions#destroy"

  resources :users

  namespace :admin do
    root "sessions#new"
    resources :books
  end
end
