Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  get 'about', to: 'pages#about'
  get 'join', to: 'volunteers#index'
  resources :policy_makings, except: [:destroy], shallow: true do
    resources :questions, only: [:create, :update], shallow: true do
      resources :answers, only: [:create, :edit, :update]
    end
  end
  resources :institutions, except: [:show, :destroy]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
