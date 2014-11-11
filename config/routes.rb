Rails.application.routes.draw do

  devise_for :users, controllers: {omniauth_callbacks: "authentications", registrations: "registrations"}
  devise_scope :user do
    delete 'authentications/:id' => 'authentications#destroy', as: :authentication
  end

  root 'statics#home'

end
