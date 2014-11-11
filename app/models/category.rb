class Category < ActiveRecord::Base
  
  def label
    if name=="my_content"
      'label-success'
    else
      'label-primary'
    end
  end

  def to_s
    I18n.t("categories.#{name}")
  end
end
