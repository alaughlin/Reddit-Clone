Rails.application.routes.draw do

  resources :users

  resources :subs do
    resources :posts, except: [:show, :destroy], shallow: true
    resources :posts, only: :show
  end

  resource :session, only: [:new, :create, :destroy]

  resources :posts, only: :show do
    resources :comments, only: [:new, :create]
  end
end
