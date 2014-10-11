# encoding: utf-8
class StaticsController < ApplicationController

  def home
    if user_signed_in?
      render :home
    else
      render :landing
    end
  end
end
