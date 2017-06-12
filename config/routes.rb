Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'registrations' }

  resources :fraternities

  root 'pages#home'
end
