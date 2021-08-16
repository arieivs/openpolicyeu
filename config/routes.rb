Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  get 'about', to: 'pages#about'
  get 'join', to: 'volunteers#index'
  get 'contribute', to: 'pages#contribute'
  resources :policy_makings, except: [:destroy]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
