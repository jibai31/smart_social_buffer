module LayoutHelper

  def get_alert_type(flash_type)
    case flash_type
    when :alert
      "alert-error"
    when :notice
      "alert-success"
    else
      "alert-info"
    end
  end

  def navbar_menu(title, url)
    content_tag(:li, class: ('active' if request.original_fullpath==url)) do
      link_to title, url
    end
  end
end
