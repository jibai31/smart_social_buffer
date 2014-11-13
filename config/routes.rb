Rails.application.routes.draw do

  resources :buffered_posts, only: [:index, :destroy] do
    collection do
      get 'fill'
    end
  end
  get '/timeline' => "buffered_posts#index", as: :timeline

  get '/contents/c/:category_id' => 'contents#index', as: :contents_with_category

  resources :contents do
    resources :messages, except: [:index]
  end

  resources :blogs, except: [:index] do
    member do
      get 'import'
    end
  end

  devise_for :users, controllers: {omniauth_callbacks: "authentications", registrations: "registrations"}
  devise_scope :user do
    resources :authentications, only: [:index, :destroy]
    get '/settings' => "authentications#index", as: :settings
  end

  root 'statics#home'

end
