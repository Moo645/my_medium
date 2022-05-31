Rails.application.routes.draw do
  root 'pages#index'
  # devise
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  
  # api
  namespace :api do
    namespace :v1 do
      resources :users, only: [] do
        member do
          post :follow
        end
      end
  
      resources :stories, only: [] do 
        member do
          post :clap
          post :bookmark
        end
      end

    end
  end

  # crud
  resources :stories do 
    resources :comments, only: [:create]
  end
  
  # /@username/story-123
  get '/@:username/:story_id', to: 'pages#show', as: 'story_page'
  # /@username
  get '/@:username', to: 'pages#user', as: 'user_page'
  
end
