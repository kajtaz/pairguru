Rails.application.routes.draw do
  devise_for :users

  root "home#welcome"
  resources :genres, only: :index do
    member do
      get "movies"
    end
  end
  resources :movies, only: [:index, :show] do
    resources :comments
    member do
      get :send_info
    end
    collection do
      get :export
    end
  end
  get '/users/most_active', to: 'users#most_active'
end
