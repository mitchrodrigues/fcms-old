module Auth
  module Controller
    USER_SESSION_KEY = :user_id

    def require_and_init_login
      return redirect_to login_path unless session[USER_SESSION_KEY].present?
      return redirect_to login_path unless current_user.present?
      true
    end

    def current_user
      if @current_logged_in_user.nil? && session[USER_SESSION_KEY]
        @current_logged_in_user = User.find(session[USER_SESSION_KEY])
      end

      @current_logged_in_user
    rescue => e
      nil
    end

    def current_user_profile
      @profile ||= current_user.profile if current_user
    end

    # Aliases so it can be consistent
    # TODO: Not sure i like this - Mitch (Perhaps im over thinking)
    def log_in_user_session_only(user_id)
      session[USER_SESSION_KEY] = user_id
    end

    def log_in_user(user, remote_ip = 'unknown')
      if user
        user.update_login_info(remote_ip)
        session[USER_SESSION_KEY] = user.id
      end
    end

    def log_out_user
      session.delete USER_SESSION_KEY
      session.clear
    end


    def login_required?
      true
    end

  end
end
