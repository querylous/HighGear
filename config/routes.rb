Rails.application.routes.draw do
  root 'users#index'
  get 'signup' => 'users#new'

  resource :users
end
