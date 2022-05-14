Rails.application.routes.draw do
  root to: 'questions#index'

  resources :questions do
    member do
      patch :hide
    end
  end

  resource :session, only: %i[new create destroy]

  resources :hashtags, only: %i[show]
  resources :users, except: %i[index]
end
