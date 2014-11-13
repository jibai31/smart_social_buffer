# encoding: UTF-8
class RegistrationsController < Devise::RegistrationsController
  layout "settings", only: [:edit]

  def edit
    @blog = Blog.new
    super
  end

  private

  def build_resource(*args)
    super
    if auth
      UserFactory.new(auth, @user).build
      @user.valid?
    end
  end

  def auth
    session["devise.omniauth"]
  end
end
