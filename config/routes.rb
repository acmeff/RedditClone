Rails.application.routes.draw do

  resources :comments, only: [:create, :show] do
    member do
      post 'upvote'
      post 'downvote'
    end
  end

  resources :posts, except: [:index] do
    resources :comments, only: [:new]
    member do
      post 'upvote'
      post 'downvote'
    end
  end
  resources :subs, except: [:destroy]

  resources :users
  resource :session

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
