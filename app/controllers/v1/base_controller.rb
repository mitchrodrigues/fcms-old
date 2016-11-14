require 'auth/controller'

module V1
  class BaseController < ApplicationController
    include Auth::Controller

    before_action :require_and_init_login_for_api, except: [:options_route]
    
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

    def with(*args)
      parv = args.collect do |arg| 
        rec = send(arg)        
        return api_render(false, "ERROR.#{arg.to_s.upcase}_NOT_FOUND") if ! rec
        rec
      end

      yield *parv
    end

    def api_log(message)
    end


  before_action :set_paper_trail_whodunnit, if: ->() { current_user.present? }
  def user_for_paper_trail
    current_user.subject if current_user
  end




  end
end