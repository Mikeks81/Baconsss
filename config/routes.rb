Rails.application.routes.draw do
  root 'homes#index'

  devise_for :users
  resources :users do
	  resources :contacts
	  resources :phones
	  resources :profiles
	end
end
