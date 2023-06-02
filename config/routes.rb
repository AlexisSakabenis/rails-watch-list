Rails.application.routes.draw do
  resources :articles

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  resources :movies, only: [:index, :show]
  resources :lists do
    resources :bookmarks, only: [:create, :destroy, :show]
  end

  root 'movies#index'
end

Rails.application.routes.draw do
  root to: "articles#index"
  resources :articles, except: :index
end
