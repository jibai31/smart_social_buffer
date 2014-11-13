module NavbarHelper

  def navbar_menu(title, url)
    content_tag(:li, class: ('active' if page_from_menu?(title))) do
      link_to title, url
    end
  end

  def page_from_menu?(menu)
    current_layout == menu.downcase
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
