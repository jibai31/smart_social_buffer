Rails.application.routes.draw do


  resources :contents do
    resources :messages
  end

  resources :blogs

  devise_for :users, controllers: {omniauth_callbacks: "authentications", registrations: "registrations"}
  devise_scope :user do
    resources :authentications, only: [:index, :destroy]
  end

  root 'statics#home'

end
