module V1
  module Children
    class BaseController < ::V1::BaseController
      
      # private
        def lookup_child
          return api_render(false, Errors::RECORD_NOT_FOUND) unless child
          child
        end

        def child
          unless @child
            @child = Child.find(params[:child_id]) rescue nil
          end
          @child
        end
    end
  end
end