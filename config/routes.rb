Rails.application.routes.draw do
  root 'pages#index'
  
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  
  resources :users, only: [] do
    member do
      post :follow
    end
  end

  resources :stories do 
    member do
      post :clap
    end
    resources :comments, only: [:create]
  end
  
  # /@username/story-123
  get '/@:username/:story_id', to: 'pages#show', as: 'story_page'
  # /@username
  get '/@:username', to: 'pages#user', as: 'user_page'
  
end
