class ApplicationController < ActionController::Base
  protect_from_forgery

  def after_sign_in_path
    dashboard_path
  end

  def not_found
    raise ActionController::RoutingError.new('Not Found')
  end
  
  def ckeditor_filebrowser_scope(options = {})
    super({ :assetable_id => current_user.id, :assetable_type => 'User' }.merge(options))
  end
end
