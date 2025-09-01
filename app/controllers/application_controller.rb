class ApplicationController < ActionController::Base
  include Pundit::Authorization
  
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :check_session_timeout
  after_action :verify_authorized, except: [:index, :show], unless: :skip_authorization?
  after_action :verify_policy_scoped, only: :index, unless: :skip_policy_scope?

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :employee_id, :business_unit_id])
    devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name, :business_unit_id])
  end

  def check_session_timeout
    return unless user_signed_in?
    
    if session[:last_activity] && session[:last_activity] < 30.minutes.ago
      sign_out current_user
      redirect_to new_user_session_path, alert: 'Your session has expired. Please sign in again.'
    else
      session[:last_activity] = Time.current
    end
  end

  def user_not_authorized(exception)
    policy_name = exception.policy.class.to_s.underscore
    
    flash[:alert] = t "#{policy_name}.#{exception.query}", scope: "pundit", default: :default
    redirect_back_or_to(dashboard_path)
  end

  def skip_authorization?
    devise_controller? || controller_name == 'rails/health'
  end

  def skip_policy_scope?
    devise_controller? || controller_name == 'rails/health'
  end

  def redirect_back_or_to(fallback_location)
    redirect_back(fallback_location: fallback_location)
  end

  def current_ability
    @current_ability ||= Ability.new(current_user)
  end
end