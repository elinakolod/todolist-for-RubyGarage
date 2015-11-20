class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery
  skip_before_filter  :verify_authenticity_token
  
  rescue_from CanCan::AccessDenied do |exception|
    render :file => "#{Rails.root}/public/422.html", :status => 422, :layout => true
  end
end
