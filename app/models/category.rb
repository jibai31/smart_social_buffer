# encoding: UTF-8
class Category < ActiveRecord::Base
  
  def label
    "label-#{name}"
  end

  def to_s
    I18n.t("categories.#{name}")
  end
end
