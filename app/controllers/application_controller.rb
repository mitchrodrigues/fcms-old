class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  # protect_from_forgery with: :exception
  # rescue_from ActionController::RoutingError, with: :handle_options

  after_action :cors_headers

  def cors_headers    
    response.headers['Access-Control-Request-Method'] = "GET, POST, DELETE, OPTIONS"
    headers['Access-Control-Allow-Origin']            = "http://localhost:3333"
    headers['Access-Control-Allow-Credentials']       = 'true'
  end

  def options_route
    headers['Access-Control-Allow-Origin'] = "http://localhost:3333"
    headers['Access-Control-Allow-Methods'] = 'POST, GET, PUT, DELETE, OPTIONS'
    headers['Access-Control-Allow-Headers'] = 'X-Requested-With, X-Prototype-Version, Token'
    headers['Access-Control-Max-Age'] = '1728000'

    return head :ok
  end
end
