class Users::RegistrationsController < Devise::RegistrationsController

  def build_resource(hash=nil) 
    hash[:uid] = User.create_unique_string 
    super 
  end

  
  private
  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:image,:name,:avatar,:email ) }
  end
  
  protected
  def update_resource(resource, params)
    resource.update_without_current_password(params)
  end
  
end
