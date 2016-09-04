TryApi::Engine.routes.draw do

  root to: 'pages#index'

  resources :projects, only: :index

end
