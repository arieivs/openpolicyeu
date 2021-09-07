Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  get 'about', to: 'pages#about', as: :about
  get 'join', to: 'volunteers#index', as: :join
  get 'policy_makings/:policy_making_id/choose_institution/:policy_making_institution_id', to: 'policy_makings#choose_institution', as: :pm_choose_institution
  resources :policy_makings, except: [:destroy], shallow: true do
    resources :questions, only: [:create, :edit, :update], shallow: true do
      resources :answers, only: [:create, :edit, :update]
    end
    resources :policy_making_institutions, only: [:create, :edit, :update, :destroy]
  end
  get 'questions/:question_id/select_answer_quiz/:answer_id/', to: 'questions#select_answer_quiz', as: :select_answer_quiz
  resources :institutions, except: [:show, :destroy]

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
