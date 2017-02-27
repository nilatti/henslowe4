class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :configure_permitted_parameters, if: :devise_controller?

  after_filter :store_location

  rescue_from CanCan::AccessDenied do |exception|
	  flash[:error] = "Access denied!"
	  redirect_to root_url
  end

  def after_accept_path_for(resource)
    root_path # you can define this yourself. Just don't use session[:previous_url]
  end

  def after_sign_in_path_for(resource)
    session[:previous_url] || root_path
  end

protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:accept_invitation) do |u|
      u.permit(:password, :password_confirmation, :invitation_token)
    end
    devise_parameter_sanitizer.for(:invite).concat [:first_name, :last_name, jobs_attributes: [:id, :specialization_id, :theater_id, :start_date, :end_date, :production_id, :_destroy]]
    devise_parameter_sanitizer.for(:account_update).concat [:first_name, :last_name, jobs_attributes: [:id, :specialization_id, :theater_id, :start_date, :end_date, :production_id, :_destroy]]
    devise_parameter_sanitizer.for(:sign_up).concat [:first_name, :last_name, :email]

  end

  def store_location
  # store last url - this is needed for post-login redirect to whatever the user last visited.
    return unless request.get?
    if (request.path != "/users/sign_in" &&
      request.path != "/users/sign_up" &&
      request.path != "/users/password/new" &&
      request.path != "/users/password/edit" &&
      request.path != "/users/confirmation" &&
      request.path != "/users/sign_out" &&
      !request.xhr?) # don't store ajax calls
      session[:previous_url] = request.fullpath
    end
  end


end
