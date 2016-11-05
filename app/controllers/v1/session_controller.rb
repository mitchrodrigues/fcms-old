module V1
  class SessionController < BaseController    

    skip_before_action :require_and_init_login_for_api
    
    def create
      return unless require_parameters(:email, :password)

      user = Person.login(params[:email], params[:password])
      if user.blank?   
        return api_render(false, "AUTH.LOGIN_INVALID")
      end

      log_in_user(user)

      puts session[:user_id].inspect

      api_render(true, "AUTH.LOGIN_SUCCESS", user: user.as_json)
    end

    def destroy
      log_out_user

      api_render(true, "AUTH.LOGOUT_SUCCESS")
    end


    def index
      return api_render(false, "AUTH.NOT_LOGGED_IN") unless current_user
      return api_render(true, "AUTH.LOGGED_IN", user: current_user.as_json)
    end
  end
end