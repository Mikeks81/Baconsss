Rails.application.routes.draw do
  require 'sidekiq/web'

  authenticated :user do
    root :to => "users#show"
  end
  root 'homes#index'

  post 'twilios/user_response' => 'twilios#user_text_response'

  devise_for :users
  resources :users do
	  resources :contacts
	  resources :phones
	  resources :profiles
    resources :twilios, only: [:index, :create, :update, :destroy]
    resources :locations, only: [:create]
	end

  mount Sidekiq::Web => '/sidekiq'
end
