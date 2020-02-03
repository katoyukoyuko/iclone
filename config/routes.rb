Rails.application.routes.draw do
  resources :pictures do
    collection do
      post :confirm
      patch :confirm
    end
  end
  
  resources :users, only: [:new, :create, :show]
  resources :sessions, only: [:new, :create, :destroy]
  resources :favorites, only: [:create, :destroy]
end
