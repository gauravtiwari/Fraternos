Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'registrations' }

  authenticated :user do
    root 'fraternities#index', as: :authenticated_root
  end

  resources :fraternities, shallow: true do
    resources :memberships
  end

  root 'pages#home'
end
