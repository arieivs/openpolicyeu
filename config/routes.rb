Rails.application.routes.draw do
  devise_for :users, skip: :registrations
  devise_scope :user do
    get 'users/edit', to: 'devise/registrations#edit', as: 'edit_user_registration'
    put 'users', to: 'devise/registrations#update', as: 'user_registration'
  end
  root to: 'pages#home'
  get 'about', to: 'pages#about', as: :about
  get 'explore', to: 'pages#explore', as: :explore
  get 'join', to: 'volunteers#index', as: :join

  get 'policy_makings/:policy_making_id/choose_institution/:policy_making_institution_id', to: 'policy_makings#choose_institution', as: :pm_choose_institution
  resources :policy_makings, except: [:destroy], shallow: true do
    resources :questions, only: [:create, :edit, :update], shallow: true do
      resources :answers, only: [:create, :edit, :update, :destroy]
    end
    resources :policy_making_institutions, only: [:create, :edit, :update, :destroy]
  end
  get 'questions/:question_id/select_answer_quiz/:answer_id/', to: 'questions#select_answer_quiz', as: :select_answer_quiz

  get 'policy_plans/:policy_plan_id/choose_institution/:policy_plan_institution_id', to: 'policy_plans#choose_institution', as: :pp_choose_institution
  get 'policy_plans/:id/choose_gamebook', to: 'policy_plans#choose_gamebook', as: :choose_gamebook
  get 'policy_plans/:id/choose_timeline', to: 'policy_plans#choose_timeline', as: :choose_timeline
  get 'policy_plans/:policy_plan_id/open_accordion/:goal_id', to: 'policy_plans#open_accordion', as: :open_accordion
  get 'policy_plans/:policy_plan_id/close_accordion/:goal_id', to: 'policy_plans#close_accordion', as: :close_accordion
  resources :policy_plans, except: [:destroy], shallow: true do
    resources :policy_plan_institutions, only: [:create, :edit, :update, :destroy]
    resources :timesteps, only: [:create, :edit, :update, :destroy]
    resources :goals, only: [:create, :edit, :update, :destroy]
    resources :game_questions, only: [:create, :edit, :update, :destroy], shallow: true do
      resources :game_answers, only: [:create, :edit, :update, :destroy]
    end
  end
  get 'policy_plans/:policy_plan_id/game_questions/:game_question_id/:game_question_index/select_answer_gamebook/:game_answer_id/', to: 'game_questions#select_answer_gamebook', as: :select_answer_gamebook
  get 'game_questions/:game_question_id/select_answer_goal/:game_answer_id', to: 'game_questions#select_answer_goal', as: :select_answer_goal

  resources :institutions, except: [:show, :destroy]
  resources :organisations, only: [:index]

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
