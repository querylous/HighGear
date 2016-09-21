Rails.application.routes.draw do
  get 'sessions/new'

  root   'foods#index'
  get    'signup'  => 'users#new'
  get    'login'   => 'sessions#new'
  post   'login'   => 'sessions#create'
  delete 'logout'  => 'sessions#destroy'
  post   'foods/sort' => 'foods#sort'
  post   'foods/upload' => 'foods#upload'
  post   'waste_counts/new' => 'waste_counts#new'
  get    'foods/today_counts' => 'foods#today'
  get    'foods/search' => 'foods#search'
  get    'foods/my_today' => 'foods#my_today'
  get    'sales_hours/process_projections' => 'sales_hours#process_projections'
  resources :users
  resources :foods
  resources :waste_counts
  resources :sales_hours
end
