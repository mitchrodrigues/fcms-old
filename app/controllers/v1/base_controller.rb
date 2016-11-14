require 'auth/controller'
require 'errors'

module V1
  class BaseController < ApplicationController
    include Auth::Controller

    before_action :require_and_init_login_for_api, except: [:options_route]
    
    def require_parameters(*parms)
      parms.each do |parm|
        if params[parm].blank?
          api_render(false, { key: Errors::MISSING_PARAMS })
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
        if !(rec = send(arg))
          return api_render(false, 
                  Errors::RECORD_NOT_FOUND, 
                  error: ["#{arg.to_s.titlecase} not found."])
        end
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