Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get '/book-search', to: 'books#index', as: 'books'
      get '/forecast', to: 'forecasts#show', as: 'forecasts'
      post '/road_trip', to: 'road_trips#create', as: 'road_trips'
      resources :users, only: [:create]
      resources :sessions, only: [:create, :destroy]
    end
  end
end
