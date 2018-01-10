Rails.application.routes.draw do

  get 'login', to: redirect('/auth/google_oauth2'), as: 'login'
  get 'logout', to: 'sessions#destroy', as: 'logout'

  get 'auth/:provider/callback', to: 'sessions#create'
  get 'auth/failure', to: redirect('/')

  get 'dashboard', to: 'pages#dashboard', as: 'dashboard'

  root to: 'pages#home'
end
