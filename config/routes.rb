Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :books, only: [:new, :create, :show, :index, :destroy], shallow: true do
    resources :reviews, only: [:new, :create]
  end
  # resources :reviews
  resources :users
  resources :authors
end
