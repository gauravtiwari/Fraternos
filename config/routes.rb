Rails.application.routes.draw do
  devise_for :users
  resources :fraternities
  root 'pages#home'
end
