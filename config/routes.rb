Rails.application.routes.draw do

  resources :users, :posts, :subs
  resource :session, only: [:new, :create, :destroy]

end
