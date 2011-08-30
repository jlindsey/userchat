module ApplicationHelper
  def nav_item ctrl, action, title
    opts = current_page?(:controller => ctrl, :action => action) ? { :class => 'active' } : {}

    capture_haml do
      haml_tag :li, opts do
        haml_tag :a, title, { :href => url_for(:controller => ctrl, :action => action) }
      end
    end
  end

  def service_icon_link service_name, size = '128'
    capture_haml do
      haml_tag :a, 
        image_tag("#{service_name =~ /openid/ ? 'openid' : service_name}_#{size}.png"), 
        { :href => "/auth/#{service_name.to_sym}" }
    end
  end
end
