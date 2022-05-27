Rails.application.routes.draw do
  root 'pages#index'
  
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }

  resources :stories do 
    resources :comments, only: [:create]
  end

  # /@username/story-123
  get '/@:username/:story_id', to: 'pages#show', as: 'story_page'
  # /@username
  get '/@:username', to: 'pages#user', as: 'user_page'

end
