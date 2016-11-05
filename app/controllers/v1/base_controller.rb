require 'auth/controller'

module V1
  class BaseController < ApplicationController
    include Auth::Controller

    before_action :require_and_init_login_for_api
    
    def require_parameters(*parms)
      parms.each do |parm|
        if params[parm].blank?
          api_render(false, { key: "ERROR.MISSING_PARAMS" })
          return false
        end
      end
      true
    end

    def api_render(success, *args, **json)
      result  = { success: success }.merge(json)
      result[:key] = args.first if args.first.present?
      render json: result
    end


    def api_log(message)

    end

  end
end