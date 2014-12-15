module NavbarHelper

  def navbar_menu(title, url)
    content_tag :li, class: ('active' if page_from_menu?(title, url) ) do
      link_to title, url
    end
  end

  def page_from_menu?(menu_title, url)
    same_url?(url) || same_layout_name?(menu_title)
  end

  def same_url?(url)
    current_url == url
  end

  def same_layout_name?(menu_title)
    current_layout == menu_title.downcase
  end

  def current_url
    request.original_fullpath
  end

  def current_layout
    layout = controller.send(:_layout)
    if layout.instance_of? String
      layout
    else
      File.basename(layout.identifier).split('.').first
    end
  end
end
