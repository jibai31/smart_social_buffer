# encoding: UTF-8
class Category < ActiveRecord::Base
  
  def tag
    "tag-#{name}"
  end

  def label
    "label-#{name}"
  end

  def to_s
    I18n.t("categories.#{name}")
  end
end
