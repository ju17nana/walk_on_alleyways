Rails.application.routes.draw do
  resources :users
  root to: 'static_pages#top'

  resources :users, only: %i[ new create destroy ]
end
