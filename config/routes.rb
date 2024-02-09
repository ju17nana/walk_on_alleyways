Rails.application.routes.draw do
  root to: 'static_pages#top'
  resources :users, only: %i[ new create destroy ]

  get 'login', to: 'user_sessions#new'
  post 'login', to: 'user_sessions#create'
  delete 'logout', to: 'user_sessions#destroy'
  get 'about', to: 'static_pages#about'
end
