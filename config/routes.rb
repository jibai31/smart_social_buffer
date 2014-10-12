Rails.application.routes.draw do

  devise_for :users, controllers: {omniauth_callbacks: "authentications"}

  root 'statics#home'

end
