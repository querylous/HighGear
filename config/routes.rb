Rails.application.routes.draw do
  get 'sessions/new'

  root   'users#index'
  get    'signup'  => 'users#new'
  get    'login'   => 'sessions#new'
  post   'login'   => 'sessions#create'
  delete 'logout'  => 'sessions#destroy'
  post   'foods/sort' => 'foods#sort'
  post   'foods/upload' => 'foods#upload'
  post   'waste_counts/new' => 'waste_counts#new'
  get    'foods/today_counts' => 'foods#today'
  get    'foods/search' => 'foods#search'
  resources :users
  resources :foods
  resources :waste_counts
end
