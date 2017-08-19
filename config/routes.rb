Rails.application.routes.draw do
  post '/', to: 'cards#index'

  root 'cards#index'
  resources :cards

end
