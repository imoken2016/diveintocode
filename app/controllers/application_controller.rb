class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :set_mailer_host
  
  before_filter :configure_permitted_parameters, if: :devise_controller?
  protected
    def configure_permitted_parameters
      devise_parameter_sanitizer.for(:account_update) << :name
    end
  
  private
    def set_mailer_host
      ActionMailer::Base.default_url_options[:host] = request.host_with_port
    end

    def sign_in_required
      redirect_to new_user_session_url unless user_signed_in?
    end
  
end
