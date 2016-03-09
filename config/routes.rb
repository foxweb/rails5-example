Rails.application.routes.draw do
  resource  :session
  resources :users
  resources :posts do
    resources :comments
  end

  mount ActionCable.server => '/cable'
  
  root to: 'posts#index'
end
