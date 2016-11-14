module V1
  module Children
    class BaseController < ::V1::BaseController
      
      private
        def lookup_child
          return api_render(false, "ERROR.RECORD_NOT_FOUND") unless child
          child
        end

        def child
          unless @child
            id = params[:child_id] || params[:id]
            @child = Child.find(id) rescue nil
          end
          @child
        end
    end
  end
end