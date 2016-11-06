class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  # protect_from_forgery with: :exception
  after_action :cors_headers

  def cors_headers    
    response.headers['Access-Control-Request-Method'] = "GET, POST, OPTIONS"


    response.headers['Access-Control-Allow-Origin']   = "http://localhost:3333"
    response.headers['Access-Control-Allow-Credentials'] = 'true'
  end
end
