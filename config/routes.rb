Rails.application.routes.draw do
  get 'sessions/new'

  root 'users#index'
  get 'signup' => 'users#new'

  resources :users
end
