Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get '/book-search', to: 'books#index', as: 'books'
      get '/forecast', to: 'forecasts#show', as: 'forecasts'
      resources :users, only: [:create]
      resources :sessions, only: [:create, :destroy]
      resources :road_trips, only: [:create], as: :road_trips
    end
  end
end
