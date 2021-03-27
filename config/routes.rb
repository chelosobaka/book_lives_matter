Rails.application.routes.draw do
root to: "books#index"
  devise_for :users
  resources :users, only: [:index, :show] do
    get "reviews", to: "users#user_reviews"
    get "subscriptions_reviews", to: "users#subscriptions_reviews"
    resources :lists
    get :followers, :subscriptions
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :books do
    resources :reviews
  end
  resources :authors
  resources :book_lists, only: [:create, :destroy]
  resources :follows, only: [:create, :destroy]
end
