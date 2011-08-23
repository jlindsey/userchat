module ApplicationHelper
  def nav_item ctrl, action, title
    opts = current_page?(:controller => ctrl, :action => action) ? { :class => 'active' } : {}

    capture_haml do
      haml_tag :li, opts do
        haml_tag :a, title, { :href => url_for(:controller => ctrl, :action => action) }
      end
    end
  end
end
