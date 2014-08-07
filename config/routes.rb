Rails.application.routes.draw do

  resources :users
  resources :subs, shallow: true do
    resources :posts
  end
  resource :session, only: [:new, :create, :destroy]

end
