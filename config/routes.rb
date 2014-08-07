Rails.application.routes.draw do

  resources :users

  resources :subs do
    resources :posts, except: [:show, :destroy, :index], shallow: true
    resources :posts, only: :show
  end

  get 'post/:id', to: 'posts#full_show', as: 'full_show'

  resource :session, only: [:new, :create, :destroy]

end
