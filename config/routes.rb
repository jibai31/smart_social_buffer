Rails.application.routes.draw do

  # Content
  get '/contents/c/:category_id' => 'contents#index', as: :contents_with_category
  resources :contents do
    resources :messages, except: [:index, :show]
  end

  resources :blogs, except: [:index] do
    member do
      get 'import'
    end
    collection do
      post 'autoimport'
    end
  end

  # Users, accounts and planning
  devise_for :users, controllers: {omniauth_callbacks: "accounts", registrations: "registrations"}
  devise_scope :user do
    resources :accounts, only: [:index, :destroy] do
      resources :plannings, only: [:show]
      resources :buffered_weeks, only: [] do
        get 'preview'
        get 'plan'
      end
    end
    get '/settings' => "accounts#index", as: :settings
  end
  resources :plannings, only: [:index]

  # Home page
  root 'statics#home'

end
