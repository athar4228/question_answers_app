Rails.application.routes.draw do

  resources :questions do
    resources :answers, only: [:create, :edit, :update, :destroy]
  end

  get 'login', to: redirect('/auth/google_oauth2'), as: 'login'
  get 'logout', to: 'sessions#destroy', as: 'logout'

  get 'auth/:provider/callback', to: 'sessions#create'
  get 'auth/failure', to: redirect('/')

  root to: 'pages#home'
end
