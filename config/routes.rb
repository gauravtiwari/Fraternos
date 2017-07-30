Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'registrations' }

  authenticated :user do
    root 'fraternities#index', as: :authenticated_root
  end

  resources :fraternities, shallow: true do
    resources :memberships
    resources :transactions, only: %i[index show]
    resources :payments, only: %i[new create]
    resources :debts, only: %i[new create]
    resources :meetings, only: %i[index new create]
  end

  root 'pages#home'
end
