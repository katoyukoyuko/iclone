Rails.application.routes.draw do
  resources :pictures do
    collection do
      post :confirm
      patch :confirm
    end
  end
  
  resources :users, only: [:new, :create, :show, :edit, :update]
  resources :sessions, only: [:new, :create, :destroy]
  resources :favorites, only: [:index, :create, :destroy]

  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
end
