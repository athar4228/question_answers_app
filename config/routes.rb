Rails.application.routes.draw do

  resources :questions do
    collection do
      get :search
      get :autocomplete
    end
    resources :answers, only: [:create, :edit, :update, :destroy]
  end

  get :my_questions, to: 'users#my_questions', as: :my_questions
  get :my_answers, to: 'users#my_answers', as: :my_answers

  get 'login', to: redirect('/auth/google_oauth2'), as: 'login'
  get 'logout', to: 'sessions#destroy', as: 'logout'

  get 'auth/:provider/callback', to: 'sessions#create'
  get 'auth/failure', to: redirect('/')

  root to: 'pages#home'

  get '*path', to: 'application#not_found'
end
