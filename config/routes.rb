Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'registrations' }

  resources :fraternities do
    resource :memberships, only: :destroy
  end

  root 'pages#home'
end
