module NavbarHelper

  def navbar_menu(title, url, layout_name = nil)
    content_tag(:li, class: ('active' if page_from_menu?(title, layout_name))) do
      link_to title, url
    end
  end

  def page_from_menu?(menu, layout_name = nil)
    current_layout == (layout_name || menu.downcase)
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
