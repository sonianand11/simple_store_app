class ApplicationController < ActionController::API
  include ActionController::HttpAuthentication::Basic::ControllerMethods
  include CanCan::ControllerAdditions  

  rescue_from CanCan::AccessDenied do |exception|
    render json: {error: exception.message}
  end

  def authenticate
    render_unauthorized if !(@current_user = authenticate_with_http_basic { |u, p|  User.authenticate(u,p)})
  end

  def current_user
    @current_user
  end


  def render_unauthorized(realm = "Application")
    self.headers["WWW-Authenticate"] = %(Token realm="#{realm.gsub(/"/, "")}")
    render json: 'Bad credentials', status: :unauthorized
  end
  
end
