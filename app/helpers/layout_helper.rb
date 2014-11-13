module LayoutHelper

  def get_alert_type(flash_type)
    case flash_type
    when "alert"
      "alert-danger"
    when "notice"
      "alert-success"
    else
      "alert-info"
    end
  end

  def main_title(title)
    content_for(:title) do
      content_tag :h2, title
    end
  end

  def title(title)
    content_for(:top) do
      content_tag :h2, title
    end
  end
end
