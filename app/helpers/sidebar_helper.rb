module SidebarHelper

  def selected_blog?(blog)
    request.original_fullpath == "/blogs/#{blog.id}"
  end

  def selected_category?(category)
    request.original_fullpath == "/contents/c/#{category.id}"
  end
end
