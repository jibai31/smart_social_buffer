# encoding: UTF-8
module ApplicationHelper

  # Devise helpers for use in other controllers

  def resource_name
    :user
  end

  def resource_class
    User
  end

  def resource
    @resource ||= User.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end

  def signup_variables
    @validatable = devise_mapping.validatable?
    @minimum_password_length = resource_class.password_length.min if @validatable
  end
end
