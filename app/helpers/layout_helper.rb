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
end
