Rails.application.routes.draw do
  get '/testauth', to: 'cards#test_auth'
  get '/login', to: 'cards#login'

  root 'cards#index'
  resources :cards
end
