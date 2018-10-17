Rails.application.routes.draw do
  resources :books, only: [:new, :create, :show, :index, :destroy], shallow: true do
    resources :reviews, only: [:new, :create, :destroy]
  end
  resources :users
  resources :authors
end
