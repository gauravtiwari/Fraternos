Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'registrations' }

  authenticated :user do
    root 'fraternities#index', as: :authenticated_root
  end

  resources :fraternities do
    resources :memberships
    resources :transactions, only: %i[index show create]
    resources :batch_meetings, only: %i[new create]
    resources :meetings do
      resource :attendance_records, only: :create
    end
  end

  root 'pages#home'
end
